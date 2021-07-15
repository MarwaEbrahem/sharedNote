//
//  allNotesViewController.swift
//  SharedNote
//
//  Created by marwa on 7/12/21.
//  Copyright © 2021 marwa. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class AllNotesViewController: UIViewController {
    @IBOutlet private weak var allNotesTableView: UITableView!
    @IBOutlet private weak var noInternetConnectionImg: UIImageView!
    @IBOutlet private weak var emptyMsgLabel: UILabel!
    var indicator : UIActivityIndicatorView?
    var disposeBag = DisposeBag()
    var allNotesViewModelObj : AllNotesViewModelType!
    var notesCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        allNotesViewModelObj = AllNotesViewModel()
        noInternetConnectionImg.isUserInteractionEnabled = true
        
        setupLoadingIndicator()
        setupRefreshSwipe()
        handleTableViewWithNotesData()
        handleTableViewCellSelected()
        handleInternetConnectionIssue()
        handleEmptyNoteCase()
        handleLoadingIndicator()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        allNotesViewModelObj.getNotesData()
        
    }
    @IBAction func addNoteBtn(_ sender: Any) {
        let addNoteViewController = storyboard?.instantiateViewController(identifier: Constants.addNote) as! AddNoteViewController
        addNoteViewController.notesCount = notesCount
        navigationController?.pushViewController(addNoteViewController, animated: true)
    }
}

extension AllNotesViewController{
    @objc func swipe(_ sender: UISwipeGestureRecognizer) {
        noInternetConnectionImg.isHidden = true
        allNotesViewModelObj.getNotesData()
    }
    
    func setupLoadingIndicator(){
        indicator = UIActivityIndicatorView(style: .large)
        indicator!.center = allNotesTableView.center
        view.addSubview(indicator!)
    }
    
    func setupRefreshSwipe(){
       let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipe(_:)))
        swipe.direction = .down
        noInternetConnectionImg.addGestureRecognizer(swipe)
    }
    
    func handleTableViewWithNotesData() {
        allNotesViewModelObj.notesDataDrive.drive(onNext: {[weak self] (val) in
            guard let self = self else {return}
            self.notesCount = val.count
            self.allNotesTableView.delegate = nil
            self.allNotesTableView.dataSource = nil
            Observable.just(val).bind(to: self.allNotesTableView.rx.items(cellIdentifier: Constants.noteTableCell)){row,item,cell in
                (cell as? NoteTableViewCell)?.noteData = item
                (cell as? NoteTableViewCell)?.editNotePosition = row + 1
            }.disposed(by: self.disposeBag)
            
        }).disposed(by: disposeBag)
    }
    
    func handleTableViewCellSelected() {
        allNotesTableView.rx.itemSelected.subscribe{[weak self](IndexPath) in
            guard let self = self else {return}
            let editNoteViewController = self.storyboard?.instantiateViewController(identifier: Constants.editNote) as! EditNoteViewController
            editNoteViewController.editNotePosition = IndexPath.element![1]+1
            self.navigationController?.pushViewController(editNoteViewController, animated: true)
        }.disposed(by: disposeBag)
        
    }
    
    func handleInternetConnectionIssue() {
        allNotesViewModelObj.errorDrive.drive(onNext: { [weak self](result) in
             guard let self = self else {return}
            if(result){
                self.noInternetConnectionImg.isHidden = false
                self.showToast(message: Constants.refreshMsg, font: UIFont(name: Constants.toastFont, size: 15) ?? UIFont())
            }
            else{
                self.noInternetConnectionImg.isHidden = true
            }
        }).disposed(by: disposeBag)
        
    }
    
    func handleEmptyNoteCase() {
        allNotesViewModelObj.emptyNoteDrive.drive(onNext: { [weak self](result) in
             guard let self = self else {return}
            if(result){
                self.emptyMsgLabel.isHidden = false
            }
            else{
                self.emptyMsgLabel.isHidden = true
            }
        }).disposed(by: disposeBag)
    }
    
    func handleLoadingIndicator(){
        allNotesViewModelObj.loadingDrive.drive(onNext: { [weak self](result) in
             guard let self = self else {return}
            if(result){
                self.indicator?.startAnimating()
            }
            else{
                self.indicator?.stopAnimating()
            }
        }).disposed(by: disposeBag)
    }
}

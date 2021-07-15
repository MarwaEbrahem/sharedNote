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

class allNotesViewController: UIViewController {
    
    @IBOutlet weak var allNotesTableView: UITableView!
    @IBOutlet weak var noInternetConnectionImg: UIImageView!
    @IBOutlet weak var emptyMsgLabel: UILabel!
    var indicator : UIActivityIndicatorView?
    var disposeBag = DisposeBag()
    var allNotesViewModelObj : AllNotesViewModelType!
    var notesCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allNotesViewModelObj = AllNotesViewModel()
        noInternetConnectionImg.isUserInteractionEnabled = true
        setupLoadingIndicator()
        
        //MARK: - Swipe to refresh
        setupRefreshSwipe()
        //end
        
        //MARK: - display notes data to tableview
        allNotesViewModelObj.notesDataDrive.drive(onNext: {[weak self] (val) in
            self!.notesCount = val.count
            
            self!.allNotesTableView.delegate = nil
            self!.allNotesTableView.dataSource = nil
            Observable.just(val).bind(to: self!.allNotesTableView.rx.items(cellIdentifier: Constants.noteTableCell)){row,item,cell in
                (cell as? noteTableViewCell)?.noteLabel.text = item
                (cell as? noteTableViewCell)?.noteDelegate = self
                (cell as? noteTableViewCell)?.editNotePosition = row + 1
            }.disposed(by: self!.disposeBag)
            
        }).disposed(by: disposeBag)
        //end
        
        //MARK: - handle internet connection issue
        allNotesViewModelObj.errorDrive.drive(onNext: { [weak self](result) in
            if(result){
                self?.noInternetConnectionImg.isHidden = false
                self?.showToast(message: Constants.refreshMsg, font: UIFont(name: Constants.toastFont, size: 15) ?? UIFont())
            }
            else{
                self?.noInternetConnectionImg.isHidden = true
            }
        }).disposed(by: disposeBag)
        
        //end
        
        //MARK: - empty note
        allNotesViewModelObj.emptyNoteDrive.drive(onNext: { [weak self](result) in
            if(result){
                self?.emptyMsgLabel.isHidden = false
            }
            else{
                self?.emptyMsgLabel.isHidden = true
            }
        }).disposed(by: disposeBag)
        
        //end
        
        //MARK: - loading indicator
        allNotesViewModelObj.loadingDrive.drive(onNext: { [weak self](result) in
            if(result){
                self?.indicator!.startAnimating()
            }
            else{
                self?.indicator!.stopAnimating()
            }
        }).disposed(by: disposeBag)
        
        //end
    }
    
    override func viewWillAppear(_ animated: Bool) {
        allNotesViewModelObj.getNotesData()
    }
    
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

    @IBAction func addNoteBtn(_ sender: Any) {
        let addNoteViewController = storyboard?.instantiateViewController(identifier: Constants.addNote) as! addNoteViewController
        addNoteViewController.notesCount = notesCount
        navigationController?.pushViewController(addNoteViewController, animated: true)
    }
    
    
}

extension allNotesViewController: noteCellDelegate {
    func moveToEditView(editNoteData : String ,  notePosition : Int) {
        let editNoteViewController = storyboard?.instantiateViewController(identifier: Constants.editNote) as! editNoteViewController
        editNoteViewController.editStr = editNoteData
        editNoteViewController.editNotePosition = notePosition
        navigationController?.pushViewController(editNoteViewController, animated: true)
    }
    
    
}

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
import FirebaseDatabase

class allNotesViewController: UIViewController {
    
    @IBOutlet weak var allNotesTableView: UITableView!
    @IBOutlet weak var noInternetConnectionImg: UIImageView!
    var disposeBag = DisposeBag()
    var allNotesViewModelObj : AllNotesViewModelType!
    var notesCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allNotesViewModelObj = AllNotesViewModel()
        self.allNotesTableView.delegate = self
        noInternetConnectionImg.isUserInteractionEnabled = true
        
         //MARK: - swipe to refresh
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipe(_:)))
        swipe.direction = .down
        noInternetConnectionImg.addGestureRecognizer(swipe)
        //end
        
         //MARK: - display notes data to tableview
        allNotesViewModelObj.notesDataDrive.drive(onNext: {[weak self] (val) in
            self!.notesCount = val.count
            self!.allNotesTableView.delegate = nil
            self!.allNotesTableView.dataSource = nil
            
            Observable.just(val).bind(to: self!.allNotesTableView.rx.items(cellIdentifier: Constants.noteTableCell)){row,item,cell in
                (cell as? noteTableViewCell)?.noteLabel.text = item
                (cell as? noteTableViewCell)?.noteDelegate = self
                (cell as? noteTableViewCell)?.editNotePosition = row
            }.disposed(by: self!.disposeBag)
            
        }).disposed(by: disposeBag)
        //end
       
       //MARK: - handel internet connection issue
        allNotesViewModelObj.errorDrive.drive(onNext: { [weak self](result) in
            if(result){
                self?.noInternetConnectionImg.isHidden = false
                self?.showToast(message: "swipe down to refresh", font: UIFont(name: "HelveticaNeue-ThinItalic", size: 15) ?? UIFont())
            }
            else{
                self?.noInternetConnectionImg.isHidden = true
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

    @IBAction func addNoteBtn(_ sender: Any) {
        let addNoteViewController = storyboard?.instantiateViewController(identifier: Constants.addNote) as! addNoteViewController
        addNoteViewController.notesCount = notesCount
        navigationController?.pushViewController(addNoteViewController, animated: true)
    }
    
    @IBAction func copyLinkBtn(_ sender: Any) {
       UIPasteboard.general.string = "sharedNote://"
    }
    
    
}

extension allNotesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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

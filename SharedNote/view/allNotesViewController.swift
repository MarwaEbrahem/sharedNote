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
    var disposeBag = DisposeBag()
    var allNotesViewModelObj : AllNotesViewModelType!
    var notesCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        allNotesViewModelObj = AllNotesViewModel()
        self.allNotesTableView.delegate = self
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
       
        
        allNotesViewModelObj.getNotesData()
    }

    @IBAction func addNoteBtn(_ sender: Any) {
        let addNoteViewController = storyboard?.instantiateViewController(identifier: Constants.addNote) as! addNoteViewController
        addNoteViewController.notesCount = notesCount
        navigationController?.pushViewController(addNoteViewController, animated: true)
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

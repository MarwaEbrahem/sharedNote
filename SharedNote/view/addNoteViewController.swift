//
//  addNoteViewController.swift
//  SharedNote
//
//  Created by marwa on 7/12/21.
//  Copyright © 2021 marwa. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class addNoteViewController: UIViewController {
    
    @IBOutlet weak var noteTxt: UITextView!
    var addNotesViewModelObj : AddNoteViewModelType!
    var disposeBag = DisposeBag()
    var notesCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTxt.layer.cornerRadius = 10
        noteTxt.layer.masksToBounds = true
        
        addNotesViewModelObj = AddNoteViewModel()
        
    //MARK: - handle internet connection issue
        addNotesViewModelObj.errorDrive.drive(onNext: { [weak self](result) in
            if(result){
                self?.showToast(message: Constants.internetConnectionMsg, font: UIFont(name: Constants.toastFont, size: 15) ?? UIFont())
            }
        }).disposed(by: disposeBag)
        
    //end
    //MARK: - note added successfully
        addNotesViewModelObj.addNoteDrive.drive(onNext: { [weak self] (result) in
            if(result){
                self?.navigationController?.popViewController(animated: true)
            }
        }).disposed(by: disposeBag)
    //end
    }
    
    @IBAction func addBtn(_ sender: Any) {
        addNotesViewModelObj.addNoteData(noteData: noteTxt.text ,notePosition: notesCount)
    }
    
}

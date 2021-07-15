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


class AddNoteViewController: UIViewController {
    @IBOutlet private weak var noteTxt: UITextView!
    var addNotesViewModelObj : AddNoteViewModelType!
    var disposeBag = DisposeBag()
    var notesCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTxt.layer.cornerRadius = 10
        noteTxt.layer.masksToBounds = true
        addNotesViewModelObj = AddNoteViewModel()
        handleInternetConnectionIssue()
        handleNoteAddedSuccessfullyCase()
    }
    
    @IBAction func addBtn(_ sender: Any) {
        addNotesViewModelObj.addNoteData(noteData: noteTxt.text ,notePosition: notesCount)
    }
    
}

extension AddNoteViewController {
    
    func handleInternetConnectionIssue() {
        addNotesViewModelObj.errorDrive.drive(onNext: { [weak self](result) in
            guard let self = self else {return}
            if(result){
                self.showToast(message: Constants.internetConnectionMsg, font: UIFont(name: Constants.toastFont, size: 15) ?? UIFont())
            }
        }).disposed(by: disposeBag)
    }
    
    func handleNoteAddedSuccessfullyCase() {
        addNotesViewModelObj.addNoteDrive.drive(onNext: { [weak self] (result) in
            guard let self = self else {return}
            if(result){
                self.navigationController?.popViewController(animated: true)
            }
        }).disposed(by: disposeBag)
    }
}

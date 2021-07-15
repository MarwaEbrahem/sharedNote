//
//  editNoteViewController.swift
//  SharedNote
//
//  Created by marwa on 7/12/21.
//  Copyright © 2021 marwa. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class EditNoteViewController: UIViewController {
    @IBOutlet private weak var editTxt: UITextView!
    var editNotesViewModelObj : EditNoteViewModelType!
    var disposeBag = DisposeBag()
    var editNotePosition : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editTxt.layer.cornerRadius = 10
        editTxt.layer.masksToBounds = true
        editNotesViewModelObj = EditNoteViewModel()
        handleInternetConnectionIssue()
        handleEditTextWithDataFromFirebase()
        handleNoteEditedSuccessfully()
        editNotesViewModelObj.getNoteData(notePosition: editNotePosition)
    }
    @IBAction func editBtn(_ sender: Any) {
        editNotesViewModelObj.EditNoteData(noteData: editTxt.text, notePosition: editNotePosition)
    }
    @IBAction func copyLinkBtn(_ sender: Any) {
        UIPasteboard.general.string = Constants.appLink + "\(editNotePosition)"
        self.showToast(message: Constants.copyLinkMsg, font: UIFont(name: Constants.toastFont, size: 15) ?? UIFont())
    }
}

extension EditNoteViewController {
    func handleInternetConnectionIssue() {
        editNotesViewModelObj.errorDrive.drive(onNext: { [weak self](result) in
            guard let self = self else {return}
            if(result){
                self.showToast(message: Constants.internetConnectionMsg, font: UIFont(name: Constants.toastFont, size: 15) ?? UIFont())
            }
        }).disposed(by: disposeBag)
    }
    
    func handleEditTextWithDataFromFirebase() {
        editNotesViewModelObj.noteDataDrive.drive(onNext: { [weak self] (result) in
            guard let self = self else {return}
            self.editTxt.text = result
        }).disposed(by: disposeBag)
    }
    
    func handleNoteEditedSuccessfully() {
        editNotesViewModelObj.EditNoteDrive.drive(onNext: { [weak self] (result) in
            guard let self = self else {return}
            if(result){
                self.navigationController?.popToRootViewController(animated: true)
            }
        }).disposed(by: disposeBag)
    }
}

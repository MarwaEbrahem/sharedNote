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

class editNoteViewController: UIViewController {
    @IBOutlet weak var editTxt: UITextView!
    var editNotesViewModelObj : EditNoteViewModelType!
    var disposeBag = DisposeBag()
    var editStr : String = ""
    var editNotePosition : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editTxt.layer.cornerRadius = 10
        editTxt.layer.masksToBounds = true
        editNotesViewModelObj = EditNoteViewModel()
        editTxt.text = editStr
    //MARK: - handle internet connection issue
        editNotesViewModelObj.errorDrive.drive(onNext: { [weak self](result) in
            if(result){
                self?.showToast(message: Constants.internetConnectionMsg, font: UIFont(name: Constants.toastFont, size: 15) ?? UIFont())
            }
        }).disposed(by: disposeBag)
        
    //end
    //MARK: - note edited successfully
        editNotesViewModelObj.EditNoteDrive.drive(onNext: { [weak self] (result) in
            if(result){
                self?.navigationController?.popViewController(animated: true)
            }
        }).disposed(by: disposeBag)
    //end
    }
    
   
    @IBAction func editBtn(_ sender: Any) {
        editNotesViewModelObj.EditNoteData(noteData: editTxt.text, notePosition: editNotePosition)
    }
    
}

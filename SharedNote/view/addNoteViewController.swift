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
import FirebaseDatabase

class addNoteViewController: UIViewController {
    
    @IBOutlet weak var noteTxt: UITextView!
    var addNotesViewModelObj : AddNoteViewModelType!
    private let database = Database.database().reference()
    var disposeBag = DisposeBag()
    var notesCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNotesViewModelObj = AddNoteViewModel()
        //MARK: - handel internet connection issue
               addNotesViewModelObj.errorDrive.drive(onNext: { [weak self](result) in
                   if(result){
                       self?.showToast(message: "fail,check your internet connection", font: UIFont(name: "HelveticaNeue-ThinItalic", size: 15) ?? UIFont())
                   }
               }).disposed(by: disposeBag)
              
              //end
        
        addNotesViewModelObj.addNoteDrive.drive(onNext: { (result) in
            if(result){
                self.navigationController?.popViewController(animated: true)
            }
        }).disposed(by: disposeBag)
    }
    
    @IBAction func addBtn(_ sender: Any) {
        
        addNotesViewModelObj.addNoteData(noteData: noteTxt.text ,notePosition: notesCount)
        
       
    }
    
}

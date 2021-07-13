//
//  editNoteViewController.swift
//  SharedNote
//
//  Created by marwa on 7/12/21.
//  Copyright © 2021 marwa. All rights reserved.
//

import UIKit

class editNoteViewController: UIViewController {
    @IBOutlet weak var editTxt: UITextView!
    var editNotesViewModelObj : EditNoteViewModelType!
    var editStr : String = ""
    var editNotePosition : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        editNotesViewModelObj = EditNoteViewModel()
        editTxt.text = editStr
        
    }
    
    @IBAction func copyLinkBtn(_ sender: Any) {
        
    }
    
    @IBAction func editBtn(_ sender: Any) {
        editNotesViewModelObj.EditNoteData(noteData: editTxt.text, notePosition: editNotePosition)
        navigationController?.popViewController(animated: true)
    }
    
}

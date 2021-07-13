//
//  addNoteViewController.swift
//  SharedNote
//
//  Created by marwa on 7/12/21.
//  Copyright © 2021 marwa. All rights reserved.
//

import UIKit
import FirebaseDatabase
class addNoteViewController: UIViewController {
    var addNotesViewModelObj : AddNoteViewModelType!
    @IBOutlet weak var noteTxt: UITextView!
    private let database = Database.database().reference()
    
    var notesCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNotesViewModelObj = AddNoteViewModel()

    }
    
    @IBAction func addBtn(_ sender: Any) {
        
        addNotesViewModelObj.addNoteData(noteData: noteTxt.text ,noteCount: notesCount)
        
        navigationController?.popViewController(animated: true)
    }
    
}

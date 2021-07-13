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
    @IBOutlet weak var noteTxt: UITextView!
    private let database = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addBtn(_ sender: Any) {
        database.child("note").setValue(noteTxt.text)
    }
    
}

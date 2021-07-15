//
//  noteTableViewCell.swift
//  SharedNote
//
//  Created by marwa on 7/12/21.
//  Copyright © 2021 marwa. All rights reserved.
//

import UIKit

class noteTableViewCell: UITableViewCell {
  
    @IBOutlet private weak var noteLabel: UILabel!
    var editNotePosition = 0
    var noteData : String = ""
   
    override func layoutSubviews() {
        super.layoutSubviews()
        noteLabel.text = noteData
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 10))
    }
    @IBAction func editBtn(_ sender: Any) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let editNotePage = storyBoard.instantiateViewController(identifier: Constants.editNote) as? editNoteViewController else {return}
        editNotePage.editNotePosition = editNotePosition
        let navVC = self.window?.rootViewController as? UINavigationController
        navVC?.pushViewController(editNotePage, animated: true)
    }
    
}

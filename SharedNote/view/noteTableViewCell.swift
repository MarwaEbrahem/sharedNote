//
//  noteTableViewCell.swift
//  SharedNote
//
//  Created by marwa on 7/12/21.
//  Copyright © 2021 marwa. All rights reserved.
//

import UIKit

class noteTableViewCell: UITableViewCell {
  
    @IBOutlet weak var noteLabel: UILabel!
    var noteDelegate: noteCellDelegate?
    var editNotePosition = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 10))
    }
    @IBAction func editBtn(_ sender: Any) {
        noteDelegate?.moveToEditView(editNoteData : noteLabel.text ?? "", notePosition : editNotePosition )
    }
    
}

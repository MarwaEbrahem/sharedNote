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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func editBtn(_ sender: Any) {
        noteDelegate?.moveToEditView()
    }
    
}

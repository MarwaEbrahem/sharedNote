//
//  allNotesViewController.swift
//  SharedNote
//
//  Created by marwa on 7/12/21.
//  Copyright © 2021 marwa. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class allNotesViewController: UIViewController {
    @IBOutlet weak var allNotesTableView: UITableView!
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        allNotesTableView.delegate = self
       Observable.just(["marwa","rovan"]).bind(to: allNotesTableView.rx.items(cellIdentifier: Constants.noteTableCell)){row,item,cell in
        (cell as? noteTableViewCell)?.noteLabel.text = item
        (cell as? noteTableViewCell)?.noteDelegate = self
        }.disposed(by: disposeBag)
    }
    
    @IBAction func addNoteBtn(_ sender: Any) {
        let addNoteViewController = storyboard?.instantiateViewController(identifier: Constants.addNote) as! addNoteViewController
        navigationController?.pushViewController(addNoteViewController, animated: true)
    }
    
}

extension allNotesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension allNotesViewController: noteCellDelegate {
    func moveToEditView() {
        let editNoteViewController = storyboard?.instantiateViewController(identifier: Constants.editNote) as! editNoteViewController
        navigationController?.pushViewController(editNoteViewController, animated: true)
    }
    
    
}

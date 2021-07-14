//
//  EditNoteViewModel.swift
//  SharedNote
//
//  Created by marwa on 7/13/21.
//  Copyright © 2021 marwa. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class EditNoteViewModel : EditNoteViewModelType{
    var errorDrive: Driver<Bool>
    var EditNoteDrive: Driver<Bool>
    var EditNoteSubject = PublishSubject<Bool>()
    var errorSubject = PublishSubject<Bool>()
    var databaseObj = DatabaseManager.shared
    
    init() {
        EditNoteDrive = EditNoteSubject.asDriver(onErrorJustReturn: false )
        errorDrive = errorSubject.asDriver(onErrorJustReturn: false)
    }
    
    func EditNoteData(noteData: String, notePosition: Int) {
        if(!Connectivity.isConnectedToInternet){
            errorSubject.onNext(true)
            return
        }
        errorSubject.onNext(false)
        databaseObj.addNoteToFirebase(noteStr: noteData, notePosition: notePosition) { [weak self] (result) in
            self?.EditNoteSubject.onNext(result)
        }
    }
}

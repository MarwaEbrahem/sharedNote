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
    var noteDataDrive: Driver<String>
    var errorDrive: Driver<Bool>
    var EditNoteDrive: Driver<Bool>
    var EditNoteSubject = PublishSubject<Bool>()
    var errorSubject = PublishSubject<Bool>()
    var noteDataSubject = PublishSubject<String>()
    var databaseObj = DatabaseManager.shared
    
    init() {
        EditNoteDrive = EditNoteSubject.asDriver(onErrorJustReturn: false )
        errorDrive = errorSubject.asDriver(onErrorJustReturn: false)
        noteDataDrive = noteDataSubject.asDriver(onErrorJustReturn: "" )
    }
    
    func getNoteData(notePosition : Int) {
        if(!Connectivity.isConnectedToInternet){
            errorSubject.onNext(true)
            return
        }
        errorSubject.onNext(false)
        databaseObj.readSpecificNoteFromFirebase(notePosition: notePosition, completion:{ [weak self] (result) in
            guard let self = self else {return}
            self.noteDataSubject.onNext(result)
        })
    }

    func EditNoteData(noteData: String, notePosition: Int) {
        if(!Connectivity.isConnectedToInternet){
            errorSubject.onNext(true)
            return
        }
        errorSubject.onNext(false)
        databaseObj.updateNote(noteStr: noteData, notePosition: notePosition) { [weak self] (result) in
            guard let self = self else {return}
            self.EditNoteSubject.onNext(result)
        }
    }
}

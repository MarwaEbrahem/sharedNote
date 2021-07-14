//
//  AddNoteViewModel.swift
//  SharedNote
//
//  Created by marwa on 7/13/21.
//  Copyright © 2021 marwa. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class AddNoteViewModel : AddNoteViewModelType{
    var addNoteDrive: Driver<Bool>
    var addNoteSubject = PublishSubject<Bool>()
    var databaseObj = DatabaseManager.shared
    var errorDrive: Driver<Bool>
    var errorSubject = PublishSubject<Bool>()
       
    
    init() {
        addNoteDrive = addNoteSubject.asDriver(onErrorJustReturn: false )
        errorDrive = errorSubject.asDriver(onErrorJustReturn: false)
    }
       
    func addNoteData(noteData : String , notePosition : Int) {
        if(!Connectivity.isConnectedToInternet){
            errorSubject.onNext(true)
            
                return
        }
        errorSubject.onNext(false)
        databaseObj.addNoteToFirebase(noteStr: noteData, notePosition: notePosition) { [weak self] (result) in
            self?.addNoteSubject.onNext(result)
        }
    }
    
    
}

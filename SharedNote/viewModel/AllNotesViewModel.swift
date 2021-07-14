//
//  AllNotesViewModel.swift
//  SharedNote
//
//  Created by marwa on 7/13/21.
//  Copyright © 2021 marwa. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class AllNotesViewModel : AllNotesViewModelType{
    
    var emptyNoteDrive: Driver<Bool>
    var notesDataDrive: Driver<[String]>
    var errorDrive: Driver<Bool>
    var notesDataSubject = PublishSubject<[String]>()
    var errorSubject = PublishSubject<Bool>()
    var emptyNoteSubject = PublishSubject<Bool>()
    
    var databaseObj = DatabaseManager.shared
     
       init() {
           notesDataDrive = notesDataSubject.asDriver(onErrorJustReturn: [] )
           errorDrive = errorSubject.asDriver(onErrorJustReturn: false)
           emptyNoteDrive = emptyNoteSubject.asDriver(onErrorJustReturn: false)
       }
    
    func getNotesData() {
        if(!Connectivity.isConnectedToInternet){
            errorSubject.onNext(true)
                return
        }
        errorSubject.onNext(false)
        databaseObj.readNotesDataFromFirebase { [weak self] (notesData) in
            if(notesData.count == 0){
                self?.emptyNoteSubject.onNext(true)
            }else{
                 self?.emptyNoteSubject.onNext(false)
            }
            self?.notesDataSubject.onNext(notesData)
        }
    }
    
    
}

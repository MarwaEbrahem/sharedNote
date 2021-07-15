//
//  ViewModelType.swift
//  SharedNote
//
//  Created by marwa on 7/13/21.
//  Copyright © 2021 marwa. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol AllNotesViewModelType {
     var notesDataDrive : Driver<[String]> {get}
     var errorDrive : Driver<Bool> {get}
     var emptyNoteDrive : Driver<Bool> {get}
     var loadingDrive : Driver<Bool> {get}
     func getNotesData()
}

protocol AddNoteViewModelType {
     var addNoteDrive : Driver<Bool> {get}
     var errorDrive: Driver<Bool> {get}
     func addNoteData(noteData : String , notePosition : Int)
}

protocol EditNoteViewModelType {
     var noteDataDrive : Driver<String> {get}
     var EditNoteDrive : Driver<Bool> {get}
     var errorDrive: Driver<Bool> {get}
     func EditNoteData(noteData : String , notePosition : Int)
     func getNoteData(notePosition : Int)
}

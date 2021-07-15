//
//  NotesDB.swift
//  SharedNote
//
//  Created by marwa on 7/13/21.
//  Copyright © 2021 marwa. All rights reserved.
//

import Foundation

protocol NotesDB {
   func readNotesDataFromFirebase( completion: @escaping (Array<String>) -> Void)
   func addNoteToFirebase(noteStr: String ,notePosition : Int, completion: @escaping (Bool) -> Void)
   func updateNote( noteStr: String ,notePosition : Int , completion: @escaping (Bool) -> Void)
   func readSpecificNoteFromFirebase(notePosition : Int,completion: @escaping (String) -> Void)
}

//
//  databaseManager.swift
//  SharedNote
//
//  Created by marwa on 7/13/21.
//  Copyright © 2021 marwa. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DatabaseManager {
    
    private let database = Database.database().reference()
    static let shared : DatabaseManager = DatabaseManager()
    private init() { }
    
}

extension DatabaseManager : NotesDB {
    
    func addNoteToFirebase(noteStr: String ,notePosition : Int, completion: @escaping (Bool) -> Void) {
        database.child(Constants.firebaseChild).child("\(notePosition + 1)").setValue(noteStr)
        completion(true)
    }
    
    func readNotesDataFromFirebase(completion: @escaping (Array<String>) -> Void) {
        var notesArray : Array<String> = []
        database.child(Constants.firebaseChild).observe(.value) { (snapshot) in
            notesArray = []
            for i in 1..<snapshot.childrenCount+1{
                notesArray.append(snapshot.childSnapshot(forPath: "\(i)").value as! String)
            }
            print(notesArray)
            completion(notesArray)
        }
    }    
    
    func updateNote( noteStr: String ,notePosition : Int , completion: @escaping (Bool) -> Void) {
        database.child(Constants.firebaseChild).child("\(notePosition + 1)").setValue(noteStr)
        completion(true)
    }
    
    
}

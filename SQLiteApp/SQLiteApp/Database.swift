//
//  Database.swift
//  SqliteApp
//
//  Created by Brahmastra on 05/12/19.
//  Copyright © 2019 Brahmastra. All rights reserved.
//

import Foundation
import UIKit
import SQLite3
class Database
{
    var dbPointer: OpaquePointer?
    static let sharedDB = Database()
    
    private init(){
        
    }
    func myDBCreation()
    {
        
         
        let fileUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("contactDB.sqlite")
        if sqlite3_open(fileUrl.path, &dbPointer) != SQLITE_OK {
             print("Database not Opened")
        }
        else{ print("Database is open now") }
        
        let createTableQuery = "CREATE TABLE IF NOT EXISTS contactsTable (id INTEGER PRIMARY KEY AUTOINCREMENT, fisrtname TEXT, lastname TEXT,  contactnumber INTEGER )"
        if sqlite3_exec(dbPointer, createTableQuery, nil, nil, nil) != SQLITE_OK{
            print("ERROR CREATING TABLE")
        }
        else
        {
            print("Table Created Succefully")
        }
    }
    

}

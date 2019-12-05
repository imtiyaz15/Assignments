//
//  ViewController.swift
//  SqliteApp
//
//  Created by Brahmastra on 05/12/19.
//  Copyright © 2019 Brahmastra. All rights reserved.
//
import Foundation
import UIKit
import SQLite3
class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   let dbPointer = Database.sharedDB.dbPointer
    @IBOutlet weak var contactTableView: UITableView!
    var contactList = [Contacts]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("MSg from Main ",contactList.count)
        return contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let list:Contacts
        list = contactList[indexPath.row]
        cell.textLabel?.text = " \(list.fisrtname)  \(list.lastname)"
        cell.detailTextLabel?.text = String(list.contactnumber)
        return cell
    }
    
    func reaValue(){
        contactList.removeAll()
         var stmt:OpaquePointer?
        let errorMSG = String(cString: sqlite3_errmsg(dbPointer)!)
        let selectQuery = "SELECT * FROM contactsTable"
       
        if sqlite3_prepare(dbPointer, selectQuery, -1, &stmt, nil) != SQLITE_OK{
            print("Error in prepare:", errorMSG)
            return
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = sqlite3_column_int(stmt, 0)
            let fname = String(cString: sqlite3_column_text(stmt, 1))
            let lname = String(cString: sqlite3_column_text(stmt, 2))
            let number = sqlite3_column_int(stmt, 3)
            contactList.append(Contacts(id: Int(id), fisrtname: fname, lastname: lname, contactnumber: Int(number)))
        }
        
        print("Saved data: \(contactList.count)")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Database.sharedDB.myDBCreation()
        
        contactTableView.delegate = self
        contactTableView.dataSource = self
        reaValue()
        
        // Do any additional setup after loading the view.
    }


}


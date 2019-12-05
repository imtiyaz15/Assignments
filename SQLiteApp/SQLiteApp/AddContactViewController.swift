//
//  AddContactViewController.swift
//  SqliteApp
//
//  Created by Brahmastra on 05/12/19.
//  Copyright © 2019 Brahmastra. All rights reserved.
//

import UIKit
import SQLite3
class AddContactViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {

    let dbPointer = Database.sharedDB.dbPointer
    @IBOutlet weak var txtFirstname: UITextField!
    @IBOutlet weak var txtLastname: UITextField!
    @IBOutlet weak var txtNumber: UITextField!
     var contactList = [Contacts]()
    @IBOutlet weak var listTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        reaValue()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let list:Contacts
        list = contactList[indexPath.row]
        cell.textLabel?.text = "\(list.fisrtname) \(list.lastname)"
        cell.detailTextLabel?.text = String(list.contactnumber)
        return cell
    }
    
    @IBAction func saveContact(_ sender: Any) {
       let fname = txtFirstname.text
       let lname = txtLastname.text
       let number = txtNumber.text
       if fname?.isEmpty == true{
           txtFirstname.layer.borderWidth = 0.5
               txtFirstname.layer.borderColor = UIColor.red.cgColor
           //return
       }
       else{
           
            txtFirstname.layer.borderWidth = 0
       }
       
        var stmt:OpaquePointer?
        let errorMSG = String(cString: sqlite3_errmsg(dbPointer)!)
        let insertQuery = "INSERT INTO contactsTable (fisrtname, lastname, contactnumber) VALUES (?,?,?)"
        if sqlite3_prepare(dbPointer, insertQuery, -1, &stmt, nil) != SQLITE_OK{
            print("Error in prepare:", errorMSG)
            return
        }
        if sqlite3_bind_text(stmt, 1, fname, -1, nil) != SQLITE_OK{
            print("Error in Bind Firstname :", errorMSG)
            return
        }
        
        if sqlite3_bind_text(stmt, 2, lname, -1, nil) != SQLITE_OK{
            print("Error in Bind Lastname :", errorMSG)
            return
        }
        if sqlite3_bind_int(stmt, 3, (number! as NSString).intValue) != SQLITE_OK {
            print("Error in Bind Number :", errorMSG)
            return
        }
        if sqlite3_step(stmt) != SQLITE_DONE{
            print("Error in Inserting  :", errorMSG)
            
        }
        else{
            print("data Saved:",fname!,lname!,number!)
        }
        txtNumber.text = ""
        txtLastname.text = ""
        txtFirstname.text = ""
        reaValue()
        listTableView.reloadData()
        
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        var id:Any = ""
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            let answer = ac.textFields![0]
            // do something interesting with "answer" here
      
            id = print(answer.text!)
        }
        ac.addAction(submitAction)

        present(ac, animated: true)
        
        deleteBrainDumpItem(itemId: 5)
        listTableView.reloadData()
        print("Array Counr:",contactList.count)
    }
    func deleteBrainDumpItem(itemId: Int32){

        let deleteStatementStirng = "DELETE FROM contactsTable WHERE id = ?;"

        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(dbPointer, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {

            sqlite3_bind_int(deleteStatement, 1, itemId)

            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }




        sqlite3_finalize(deleteStatement)
        listTableView.reloadData()

        print("delete")


    }
    func reaValue(){
        //contactList.removeAll()
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
            print("Saved data ID  \(id) Fname:\(fname) Lastname:\(lname) Number:\(number)")
        }
        listTableView.reloadData()
        
        print("Saved data:")
    }
    
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  AddContactViewController.swift
//  SqliteApp
//
//  Created by Brahmastra on 05/12/19.
//  Copyright © 2019 Brahmastra. All rights reserved.
//
import UIKit
import SQLite3

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var id:Int = 0
    var db: OpaquePointer?
    var heroList = [Hero]()
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var tableViewHeroes: UITableView!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldPowerRanking: UITextField!
    
    @IBAction func buttonSave(_ sender: UIButton) {
        dbOpenClose()
        print("Save Button Tapped")
        let name = textFieldName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let powerRanking = textFieldPowerRanking.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(name?.isEmpty)!{
            textFieldName.layer.borderWidth = 0.5
            textFieldName.layer.borderColor = UIColor.red.cgColor
            return
        }
        if textFieldName.isEditing == true
        {
            textFieldName.layer.borderWidth = 0.5
            textFieldName.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        if(powerRanking?.isEmpty)!{
            textFieldPowerRanking.layer.borderWidth = 0.5
            textFieldName.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        var stmt: OpaquePointer?
        
        let queryString = "INSERT INTO Heroes (name, powerrank) VALUES (?,?)"
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        if sqlite3_bind_text(stmt, 1, name, -1, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return
        }
        
        if sqlite3_bind_int(stmt, 2, (powerRanking! as NSString).intValue) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return
        }

        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting hero: \(errmsg)")
            return
        }
        
        textFieldName.text=""
        textFieldPowerRanking.text=""
        
        readValues()

        print("Herro saved successfully")
        sqlite3_close(db)
    }
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
        let hero: Hero
        hero = heroList[indexPath.row]
        cell.textLabel?.text = hero.name
        cell.detailTextLabel?.text = String(hero.powerRanking)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hero:Hero
        hero = heroList[indexPath.row]
        textFieldName.text = hero.name
        textFieldPowerRanking.text = String(hero.powerRanking)
        id = hero.id
        print(hero.id)
        deleteButton.isHidden = false
    }
    
    func deleteRecord(id:Int)
    {
        
        let deleteStatementStirng = "DELETE FROM Heroes WHERE id = ?"

        var deleteStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_int(deleteStatement, 1, Int32(id))

            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
            print(String(cString: sqlite3_errmsg(db)!))
        }

        sqlite3_finalize(deleteStatement)
        self.viewDidLoad()
        self.tableViewHeroes.reloadData()
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        if textFieldName.text?.isEmpty != true
        {
            deleteRecord(id: id)
            self.tableViewHeroes.reloadData()
            textFieldName.text = ""
            textFieldPowerRanking.text = ""
            
        }
        else
        {
            let alert = UIAlertController(title: "Alert", message: "Tap on record", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                  switch action.style{
                  case .default:
                        print("default")

                  case .cancel:
                        print("cancel")

                  case .destructive:
                        print("destructive")


            }}))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    
    func updateData(){
        let updateStatementString = "UPDATE Heroes SET name = ? WHERE Id = ?"
       
          var updateStatement: OpaquePointer? = nil
          if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            if sqlite3_step(updateStatement) == SQLITE_DONE {
              print("Successfully updated row.")
            } else {
              print("Could not update row.")
            }
          } else {
            print("UPDATE statement could not be prepared")
          }
          sqlite3_finalize(updateStatement)
        
    }
    
    
    func readValues(){
        heroList.removeAll()

        let queryString = "SELECT * FROM Heroes"
        
        var stmt:OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = sqlite3_column_int(stmt, 0)
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let powerrank = sqlite3_column_int(stmt, 2)
            
            heroList.append(Hero(id: Int(id), name: String(describing: name), powerRanking: Int(powerrank)))
        }
        
        self.tableViewHeroes.reloadData()
    }
    
    func dbOpenClose(){
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("HeroesDatabase.sqlite")
        
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Heroes (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, powerrank INTEGER)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbOpenClose()
        
        readValues()
    }
}


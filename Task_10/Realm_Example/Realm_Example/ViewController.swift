//
//  ViewController.swift
//  Realm_Example
//
//  Created by AllSpark on 12/12/19.
//  Copyright © 2019 AllSpark. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var names: Results<Movies>?
    
    
let realm = try! Realm()
  
    
    @IBOutlet var movieListTable: UITableView!
    @IBOutlet var txtName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()

        // Do any additional setup after loading the view.
    }
    
    
//Saving Data
    @IBAction func addDataButton(_ sender: Any) {
      
        
        if txtName.text == ""{
            txtName.placeholder = "Enter Movie Name"
            return
        }
        else{
        
        let newName = Movies()
        newName.name = txtName.text!
        do{
            try realm.write {
                realm.add(newName )
                alertShow(data: txtName.text!)
                txtName.text = ""
                txtName.placeholder = "Enter Movie Name"
            }
        }catch{
            print("Error in Saving Name")
        }
            movieListTable.reloadData()
    }
     
        
    }
    //Showing Data on TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return names?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = names?[indexPath.row].name ?? "No Name Added Yet"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let alert = UIAlertController(title: "Update Movie name", message: "", preferredStyle: .alert)
        var updatetextFied = UITextField()
        alert.addTextField { (alerttextField) in
        alerttextField.placeholder = "Enter to Update Movie Name"
       updatetextFied = alerttextField
        }
        
        let action = UIAlertAction(title: "Update Name", style: .default) { (action) in
            if let name = self.names?[indexPath.row]{
        do{
            try self.realm.write {
                name.name = updatetextFied.text!
                self.alertShow(data: updatetextFied.text!)
            }
            
        }catch{
              print("Error in Did Select")
        }
        }
           self.movieListTable.reloadData()
        
    }
        alert.addAction(action)
     self.present(alert,animated: true,completion: nil)
        movieListTable.reloadData()
}
    //Delete Movies Name
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           let name = names?[indexPath.row]
            
                
                do{
                    try realm.write {
                        realm.delete(name!)
                        loadData()
                    }
                    print("Delete Hit")
                } catch{
                    print("Error In Delete")
                }
        }
    
    //Getting data from DB
    func loadData(){
        names = realm.objects(Movies.self)//fetching Data
        movieListTable.reloadData()
    }
    
    func alertShow(data:String)
    {
       // create the alert
        let alert = UIAlertController(title: "Information!", message: "Your Movie is \n \(data)", preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }


}


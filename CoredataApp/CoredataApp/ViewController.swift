//
//  ViewController.swift
//  CoredataApp
//
//  Created by Brahmastra on 07/12/19.
//  Copyright © 2019 Brahmastra. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var people:[NSManagedObject] = []
    
    //var names: [String] = [] // needs to replace
    
    @IBOutlet weak var listTableView: UITableView!
    
    
    @IBAction func addButton(_ sender: Any) {
        print("add button tapped")
    let alert = UIAlertController(title: "New Name", message: "Enter new name here ", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) {
                                        [unowned self] action in
                                        
                                        guard let textField = alert.textFields?.first,
                                            let nameToSave = textField.text else {
                                                return
                                        }
                                        
                                        self.save(name: nameToSave)
                                        self.listTableView.reloadData()
        }
       
        let cancelAction  = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert,animated: true)
        
    }
    
    //This will save the data 
    
    func save(name: String) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        

        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let entity =
            NSEntityDescription.entity(forEntityName: "Person",
                                       in: managedContext)!
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        

        person.setValue(name, forKeyPath: "name")
        

        do {
            try managedContext.save()
            people.append(person)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       title = "The List"
        listTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
     
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Person")
        
    
        do {
            people = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }


}


extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let person = people[indexPath.row]
        cell.textLabel?.text = person.value(forKey: "name") as? String
        return cell
    }
    
}

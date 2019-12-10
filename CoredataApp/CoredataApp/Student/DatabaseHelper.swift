//
//  DatabaseHelper.swift
//  CoredataApp
//
//  Created by Brahmastra on 09/12/19.
//  Copyright © 2019 Brahmastra. All rights reserved.
//
// We'll handle all Core Data implementation here

import Foundation
import UIKit
import CoreData
class DatabaseHelper {
    
    static let sharedObject = DatabaseHelper() // Here I have made an static object
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext // This allows to save data

    func save(data:[String:String]){
        let student = NSEntityDescription.insertNewObject(forEntityName: "Student", into: context!) as! Student
        student.name =  data["name"]
        student.address = data["address"]
        student.city = data["city"]
        student.mobile = data["mobile"]
        do{
            
            try context?.save()
        
        }catch let nsError as NSError{
            print("Data could not be saved ERROR:", nsError , "Info: ", nsError.userInfo)
        }
    }
    
    ///Update data
    func updateData(object:[String:String], i:Int){
     var student = getStudentData()
        student[i].name = object["name"]
        student[i].address = object["address"]
        student[i].city = object["city"]
        student[i].mobile = object["mobile"]
        do{
            try context?.save()
        }catch{
            print("Somethinf gone wrong")
        }
    }
    
    
    
    
    //Fetch or Select data from here
    func getStudentData() -> [Student]{
            var student = [Student]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Student")
        do {
            student = try context?.fetch(fetchRequest) as! [Student]
        }catch{
            print("Data not got ")
        }
        return student
    }
    
    func deleteData(index:Int) -> [Student]
    {
        var student = getStudentData()
        context?.delete(student[index]) //Delete from Core data table
        student.remove(at: index) //Remove from array
        do{
           try context?.save()
        }catch let nsError as NSError {
            print(" Not  Deleted ", nsError, "Info:", nsError.userInfo)
        }
       
        return student
    }

    
    
    
}

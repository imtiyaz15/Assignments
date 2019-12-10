//
//  StudentListViewController.swift
//  CoredataApp
//
//  Created by Brahmastra on 10/12/19.
//  Copyright © 2019 Brahmastra. All rights reserved.
//

import UIKit

protocol DataPass {
    func data(object:[String:String],index:Int, isEdit:Bool)
}


class StudentListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var listTableView: UITableView!
    var student = [Student]()
    var delegate:DataPass!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return student.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentTableViewCell", for:indexPath ) as! StudentTableViewCell
        // Optimizing Code here
//        cell.lblName.text = student[indexPath.row].name
//        cell.lblAddress.text = student[indexPath.row].address
//        cell.lblCity.text = student[indexPath.row].city
//        cell.lblMobile.text = student[indexPath.row].mobile
        
        cell.student = student[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            student = DatabaseHelper.sharedObject.deleteData(index: indexPath.row)
            self.listTableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict =  ["name":student[indexPath.row].name,"address":student[indexPath.row].address,"city":student[indexPath.row].city,"mobile":student[indexPath.row].mobile]
        delegate.data(object: dict as! [String:String],index: indexPath.row, isEdit: true) //Passing data usrin delegate
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        student = DatabaseHelper.sharedObject.getStudentData()

        // Do any additional setup after loading the view.
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

//
//  StudentViewController.swift
//  CoredataApp
//
//  Created by Brahmastra on 09/12/19.
//  Copyright © 2019 Brahmastra. All rights reserved.
//

import UIKit

class StudentViewController: UIViewController,DataPass {
    
    

    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtNumber: UITextField!
    var i =  Int()
    var isUpdate = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func saveButton(_ sender: Any) {
        let  dataDictionary = ["name":txtName.text,"address":txtAddress.text,"city":txtCity.text,"mobile":txtNumber.text]
        
       
            
            
        
            if isUpdate{
                //Update
                DatabaseHelper.sharedObject.updateData(object: dataDictionary as! [String:String], i: i)
                 alertShow(title: "Message", message: "Record Saved")
            }
            else{
                DatabaseHelper.sharedObject.save(data: dataDictionary as! [String:String])
                alertShow(title: "Message", message: "Record Saved")
                }
        
        
        }
        
        
    @IBAction func showDataButton(_ sender: Any) {
        let studentListView:StudentListViewController = self.storyboard?.instantiateViewController(withIdentifier: "StudentListViewController") as! StudentListViewController
        studentListView.delegate = self //This code is  important for popview or going  to target view
        self.navigationController?.pushViewController(studentListView, animated: true)
        
    }
    
   func data(object: [String : String], index: Int, isEdit: Bool) {
        txtName.text = object["name"]
              txtAddress.text = object["address"]
              txtCity.text = object["city"]
              txtNumber.text = object["mobile"]
              i = index //getting index valu to update
              isUpdate = isEdit
    
   }
    
    func alertShow(title:String,message:String){
        let alert = UIAlertController(title: title , message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
        }))
            self.present(alert, animated: true, completion: nil)
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

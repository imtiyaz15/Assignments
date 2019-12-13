//
//  ViewController.swift
//  UserDefaults
//
//  Created by Captain on 13/12/19.
//  Copyright © 2019 Captain. All rights reserved.
//

import UIKit
class ViewController: UIViewController {

    @IBOutlet var txtUsername: UITextField!
    
    @IBOutlet var txtPassword: UITextField!
    
    @IBOutlet var myView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if UserDefaults.standard.bool(forKey:"isLogin") == true
        {
            let navobj:HomeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                self.navigationController?.pushViewController(navobj, animated: false)
            
           
        }
    }
    @IBAction func loginButton(_ sender: Any) {
        if txtUsername.text == "Define" && txtPassword.text == "Lab"{
            UserDefaults.standard.set(true, forKey: "isLogin")
        let navobj:HomeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(navobj, animated: true)
            okAlert(title:"Info!!", msg: "Success")
        }
            
        else
        {
            okAlert(title: "Warning!!", msg: "Incorrcet User ID or Password")
            print("User or Password is wrong!")
        }
        
    }
    
    
    
    func okAlert(title:String, msg:String)
    {
       let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        self.present(alert, animated: true,completion: nil)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        //alert.dismiss(animated: true, completion: nil)
        txtPassword.text = ""
        txtUsername.text = ""
        txtPassword.placeholder = "Password"
        txtUsername.placeholder = "Username"
        
    }
    
    func setRoundCorner(){
    
    }

}


//
//  HomeViewController.swift
//  UserDefaults
//
//  Created by Captain on 13/12/19.
//  Copyright © 2019 Captain. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       self.navigationItem.setHidesBackButton(true, animated: true)// This will hide Back button from Navigation view controller
      
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logoutButton(_ sender: Any) {
            UserDefaults.standard.set(false, forKey: "isLogin")
        self.navigationController?.popToRootViewController(animated: true)
        
        
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

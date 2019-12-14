//
//  NextViewController.swift
//  Task_5
//
//  Created by Thanos on 22/11/19.
//  Copyright © 2019 Thanos. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {


    @IBOutlet weak var nextImg: UIImageView!
    @IBOutlet weak var nextlabel: UILabel!
    //Data comes here from FirstViewController
    var nextImg_var:UIImage!
    var nextlbl_var:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextImg.image = nextImg_var
        nextlabel.text = nextlbl_var
        
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

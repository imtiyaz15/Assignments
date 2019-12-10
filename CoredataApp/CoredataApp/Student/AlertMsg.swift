//
//  AlertMsg.swift
//  CoredataApp
//
//  Created by Brahmastra on 10/12/19.
//  Copyright © 2019 Brahmastra. All rights reserved.
//

import Foundation
import UIKit

class AlerMsg:UIViewController {

    static let shareObj = AlerMsg()
    func showAlert(title:String, message:String){
        let alert = UIAlertController(title: "Alert!", message: "Record saved", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
        }))
            self.present(alert, animated: true, completion: nil)
    }
    
}

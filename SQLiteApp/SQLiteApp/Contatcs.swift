//
//  Contatcs.swift
//  SqliteApp
//
//  Created by Brahmastra on 05/12/19.
//  Copyright © 2019 Brahmastra. All rights reserved.
//

import Foundation
import UIKit

class Contacts
    {
    var id: Int
    var fisrtname:String
    var lastname:String
    var  contactnumber:Int
    
init(id:Int,fisrtname:String, lastname:String, contactnumber:Int ){
        self.id = id
     self.fisrtname = fisrtname
     self.lastname = lastname
      self.contactnumber = contactnumber
  }
        
}

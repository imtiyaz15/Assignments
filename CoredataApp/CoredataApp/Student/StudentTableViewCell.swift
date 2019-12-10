//
//  StudentTableViewCell.swift
//  CoredataApp
//
//  Created by Brahmastra on 10/12/19.
//  Copyright © 2019 Brahmastra. All rights reserved.
//

import UIKit

class StudentTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    //This will optimize the code 'Student' is the name of entity
    var student:Student!{
        didSet{
            lblName.text = student.name
            lblAddress.text = student.address
            lblCity.text = student.city
            lblMobile.text = student.mobile
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

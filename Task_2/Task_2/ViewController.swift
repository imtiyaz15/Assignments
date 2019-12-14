//
//  ViewController.swift
//  Task_2
//
//  Created by Vaibhav Wadhwa on 19/11/19.
//  Copyright © 2019 Vaibhav Wadhwa. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var daysPicker: UIPickerView!
    let picker = UIDatePicker()
    
    @IBOutlet weak var date_Label: UILabel!
    var days:[String] = ["Sunday", "Monday", "Tuesday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    let labelColor:[UIColor] = [#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1),#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1),#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1),#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1),#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1),#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return days.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return days[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        colorLabel.text = days[row]
        colorLabel.textColor = labelColor[row]
    }
    
    
    @objc func pickDate()
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy, hh:mm a"
        txtDate.text = formatter.string(from: picker.date)
        date_Label.text = txtDate.text
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // datePicker()
        self.colorLabel.text = "Sunday"
        self.colorLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        doneButtonToolBar()
        // Do any additional setup after loading the view.
    }
    

    func doneButtonToolBar()
    {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(pickDate))
        toolBar.setItems([done], animated: false)
        txtDate.inputAccessoryView = toolBar
        txtDate.inputView = picker
        picker.datePickerMode = .date
    }
}


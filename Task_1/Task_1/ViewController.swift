//
//  ViewController.swift
//  Task_1
//
//  Created by Vaibhav Wadhwa on 18/11/19.
//  Copyright © 2019 Vaibhav Wadhwa. All rights reserved.
//

import UIKit





class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var frontView: UIView!
    @IBOutlet weak var Label1: UILabel!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var sliderForZoom: UISlider!
    @IBOutlet weak var labelforSwitch: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var zoomLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        labelforSwitch.text = "Light is On"
        textField1.delegate = self//This hides the Keyboard when tap on "return" // UITextFieldDelegate must be set in class name
        self.hidKeyboardOnviewTap() //This hides the keyboard when tap on View
    }
    
    //To hide keyboard on return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    

    @IBAction func zoomSlider(_ sender: UISlider) {
     zoomLabel.text = "Brightness " + String(Int(Float(sender.value) * 100)) + "%"
        UIScreen.main.brightness = CGFloat(sender.value)
        frontView.alpha = CGFloat(sender.value)
        
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        print("Button Clicked ")
    }
    
    @IBAction func lightSwitch(_ sender: UISwitch) {
        if(sender.isOn == true)
        {
            frontView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
           view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            labelforSwitch.text = "Light is On"
            labelforSwitch.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        else
        {
            frontView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            labelforSwitch.text = "Light is Off"
            labelforSwitch.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    
    }
    
    @IBOutlet weak var changeImage: UISegmentedControl!
    
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        if changeImage.selectedSegmentIndex == 0
        {
            imgView.image = #imageLiteral(resourceName: "iphone6")
        }
        else if changeImage.selectedSegmentIndex == 1
        {
            imgView.image = #imageLiteral(resourceName: "iphone8")
        }
        else if changeImage.selectedSegmentIndex == 2
        {
            imgView.image = #imageLiteral(resourceName: "iphone9")
        }
        else if changeImage.selectedSegmentIndex == 3
        {
            imgView.image = #imageLiteral(resourceName: "iphone7")
        }
      else  if changeImage.selectedSegmentIndex == 4
        {
            imgView.image = #imageLiteral(resourceName: "iphoneX")
        }
    }
    
}
//This extension can be used anywhere in the program where need to hide Keyboard by tapping ViewController
extension ViewController{
    func hidKeyboardOnviewTap()
    {
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
        @objc func hideKeyBoard()
        {
            view.endEditing(true)
        }
    
}


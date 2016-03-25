//
//  SettingsViewController.swift
//  rideshare
//
//  Created by Digvijay Makwana on 2016-03-25.
//  Copyright © 2016 Digvijay Makwana. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    let user = User.sharedInstance
    
    @IBOutlet var nameText: UITextField!
    @IBOutlet var emailText: UITextField!
    @IBOutlet var numberText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameText.delegate = self
        emailText.delegate = self
        numberText.delegate = self
        
        // Set values of name,email fields to Facebook data
        nameText.text = user.full_name
        emailText.text = user.email
        
        numberText.keyboardType = UIKeyboardType.NumberPad
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if((textField == nameText)||(textField == emailText)){
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        print("hi");
        if((textField == numberText)){
            print("hello");
        }
    }
    
    @IBAction func saveButton(sender: UIButton) {
        
        // Set user's phone number
        user.phone_number = numberText.text!
    }
    
    
    
}

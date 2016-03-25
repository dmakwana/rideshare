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
    
    
    @IBOutlet var nameText: UITextField!
    @IBOutlet var emailText: UITextField!
    @IBOutlet var numberText: UITextField!
    
    
    let user = User.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameText.delegate = self
        emailText.delegate = self
        
        
        // Set values of name,email fields to Facebook data
        nameText.text = user.full_name
        emailText.text = user.email
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    // MARK: Actions
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if((textField == nameText)||(textField == emailText)){
            return false
        }
        return true
    }
    
    @IBAction func saveButton(sender: UIButton) {
        
        // Set user's phone number
        user.phone_number = numberText.text!
    }
    
    
    
}

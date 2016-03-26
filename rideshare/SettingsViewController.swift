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
    @IBOutlet var carNameText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        // Do any additional setup after loading the view, typically from a nib.
        nameText.delegate = self
        emailText.delegate = self
        numberText.delegate = self
        nameText.enabled = false
        emailText.enabled = false
        // Set values of name,email fields to Facebook data
        nameText.text = user.full_name
        emailText.text = user.email
        
        numberText.keyboardType = UIKeyboardType.NumberPad
        carNameText.keyboardType = UIKeyboardType.Alphabet
    }
    
    @IBAction func editCarNameComplete(sender: AnyObject) {
        doneEditingCarName()
    }
    
    @IBAction func editCarName(sender: UITextField) {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor.purpleColor()
        toolBar.sizeToFit()
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "doneEditingCarName")
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        self.carNameText.inputAccessoryView = toolBar
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func doneEditingCarName() {
        self.carNameText.resignFirstResponder()
    }
    
    // MARK: Actions
    
    
    // Limits number of characters for phone number
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if (textField == numberText){
            guard let number = numberText.text else { return true }
            
            let newLength = number.utf16.count + string.utf16.count - range.length
            return newLength <= 10
        }
        return true
    }
    
    @IBAction func saveButton(sender: UIButton) {
        // Set user's phone number
        user.phone_number = numberText.text!
        user.car_name = carNameText.text!
        let userService = UserService()
        userService.updateUser()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

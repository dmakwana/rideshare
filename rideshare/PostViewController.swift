//
//  PostViewController.swift
//  rideshare
//
//  Created by Digvijay Makwana on 2016-03-13.
//  Copyright © 2016 Digvijay Makwana. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    @IBOutlet var startLocField: UITextField!
    @IBOutlet var dateField: UITextField!
    @IBOutlet var endLocField: UITextField!
    @IBOutlet var numSpotsField: UITextField!
    var datePicker: UIDatePicker!
    var numSpotsPicker: UIPickerView!
    var pickerData = ["1","2","3","4"]
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        numSpotsField.text = pickerData[row]
        self.numSpotsField.resignFirstResponder()
    }
    
    @IBAction func numSpotsEditing(sender: UITextField) {
        self.numSpotsPicker = UIPickerView()
        self.numSpotsField.inputView = self.numSpotsPicker
        self.numSpotsPicker.delegate = self
        self.numSpotsPicker.dataSource = self
    }

    @IBAction func dateEditing(sender: UITextField) {
        self.datePicker = UIDatePicker()
        self.datePicker.datePickerMode = UIDatePickerMode.Date
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor.purpleColor()
        toolBar.sizeToFit()
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "doneDatePicker")
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        self.dateField.inputView = self.datePicker
        self.dateField.inputAccessoryView = toolBar
        
        self.datePicker.addTarget(self, action: Selector("datePickerValueChanged"), forControlEvents: UIControlEvents.ValueChanged);
    }
    
    func doneDatePicker() {
        self.dateField.resignFirstResponder()
    }
    
    func datePickerValueChanged() {
        print("Date Picker Value Changed");
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        self.dateField.text = dateFormatter.stringFromDate(self.datePicker.date)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
}


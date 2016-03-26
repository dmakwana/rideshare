//
//  PostViewController.swift
//  rideshare
//
//  Created by Digvijay Makwana on 2016-03-13.
//  Copyright © 2016 Digvijay Makwana. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    @IBOutlet var activeField: UISwitch!
    @IBOutlet var startLocField: UITextField!
    @IBOutlet var dateField: UITextField!
    @IBOutlet var timeField: UITextField!
    @IBOutlet var endLocField: UITextField!
    @IBOutlet var numSpotsField: UITextField!
    @IBOutlet var carField: UITextField!
    
    var datePicker: UIDatePicker!
    var timePicker: UIDatePicker!
    var numSpotsPicker: UIPickerView!
    var pickerData = ["1","2","3","4"]
    var rideService: RideService!
    
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
    
    @IBAction func timeEditing(sender: UITextField) {
        self.timePicker = UIDatePicker()
        self.timePicker.datePickerMode = UIDatePickerMode.Time
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor.purpleColor()
        toolBar.sizeToFit()
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "doneTimePicker")
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        self.timeField.inputView = self.timePicker
        self.timeField.inputAccessoryView = toolBar
        
        self.timePicker.addTarget(self, action: Selector("timePickerValueChanged"), forControlEvents: UIControlEvents.ValueChanged);
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
    
    func doneTimePicker() {
        self.timeField.resignFirstResponder()
    }
    
    func datePickerValueChanged() {
        print("Date Picker Value Changed");
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        self.dateField.text = dateFormatter.stringFromDate(self.datePicker.date)
    }
    
    func timePickerValueChanged() {
        print("Time Picker Value Changed");
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.NoStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        self.timeField.text = dateFormatter.stringFromDate(self.timePicker.date)
    }
    
    @IBAction func onSave() {
        let startLoc = startLocField.text!
        let endLoc = endLocField.text!
        let dateText = dateField.text!
        let timeString = timeField.text!
        let numSpotString = numSpotsField.text!
        let numSpots = Int(numSpotString)!
        let activeBool = activeField.on
        
        print(numSpots)
        rideService.saveRide(startLoc, end: endLoc, date: dateText, time: timeString, spots: numSpots, active: activeBool)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rideService = RideService()
        activeField.on = rideService.isRideActive()
        print(Ride.sharedInstance.ride_id)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
}


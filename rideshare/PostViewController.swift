//
//  PostViewController.swift
//  rideshare
//
//  Created by Digvijay Makwana on 2016-03-13.
//  Copyright © 2016 Digvijay Makwana. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    enum PickerTag: Int {
        // Integer values will be implicitly supplied; you could optionally set your own values
        case StartLocPickerTag
        case EndLocPickerTag
        case NumSpotsPickerTag
    }

    @IBOutlet var activeField: UISwitch!
    @IBOutlet var startLocField: UITextField!
    @IBOutlet var dateField: UITextField!
    @IBOutlet var timeField: UITextField!
    @IBOutlet var endLocField: UITextField!
    @IBOutlet var numSpotsField: UITextField!
    @IBOutlet var carField: UITextField!
    
    var startLocPicker: UIPickerView!
    var endLocPicker: UIPickerView!
    var datePicker: UIDatePicker!
    var timePicker: UIDatePicker!
    var numSpotsPicker: UIPickerView!
    var pickerData = ["1","2","3","4"]
    var rideService: RideService!
    var locations: NSArray!
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let tag = PickerTag(rawValue: pickerView.tag) {
            switch tag {
            case PickerTag.NumSpotsPickerTag:
                return pickerData.count
            case PickerTag.StartLocPickerTag:
                return locations.count
            case PickerTag.EndLocPickerTag:
                return locations.count
            }
        }
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let tag = PickerTag(rawValue: pickerView.tag) {
            switch tag {
            case PickerTag.NumSpotsPickerTag:
                return pickerData[row]
            case PickerTag.StartLocPickerTag:
                return String(locations[row])
            case PickerTag.EndLocPickerTag:
                return String(locations[row])
            }
        }
        return ""
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let tag = PickerTag(rawValue: pickerView.tag) {
            switch tag {
            case PickerTag.NumSpotsPickerTag:
                numSpotsField.text = pickerData[row]
                self.numSpotsField.resignFirstResponder()
            case PickerTag.StartLocPickerTag:
                startLocField.text = String(locations[row])
                self.startLocField.resignFirstResponder()
            case PickerTag.EndLocPickerTag:
                endLocField.text = String(locations[row])
                self.endLocField.resignFirstResponder()
            }
        }
    }
    
    @IBAction func endLocEditing(sender: UITextField) {
        self.endLocPicker = UIPickerView()
        self.endLocPicker.tag = PickerTag.EndLocPickerTag.rawValue
        self.endLocField.inputView = self.endLocPicker
        self.endLocPicker.delegate = self
        self.endLocPicker.dataSource = self
    }
    
    @IBAction func startLocEditing(sender: UITextField) {
        self.startLocPicker = UIPickerView()
        self.startLocPicker.tag = PickerTag.StartLocPickerTag.rawValue
        self.startLocField.inputView = self.startLocPicker
        self.startLocPicker.delegate = self
        self.startLocPicker.dataSource = self
    }
    
    @IBAction func numSpotsEditing(sender: UITextField) {
        self.numSpotsPicker = UIPickerView()
        self.numSpotsPicker.tag = PickerTag.NumSpotsPickerTag.rawValue
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
        self.locations = rideService.getLocations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
}


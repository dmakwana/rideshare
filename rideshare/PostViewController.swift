//
//  PostViewController.swift
//  rideshare
//
//  Created by Digvijay Makwana on 2016-03-13.
//  Copyright © 2016 Digvijay Makwana. All rights reserved.
//

import UIKit

class PostViewController: BaseViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    enum PickerTag: Int {
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
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var activePostLabel: UILabel!

    var startLocPicker: UIPickerView!
    var endLocPicker: UIPickerView!
    var datePicker: UIDatePicker!
    var timePicker: UIDatePicker!
    var numSpotsPicker: UIPickerView!
    var pickerData = ["1","2","3","4"]
    var rideService: RideService!
    var locations: NSArray!
    var ride = Ride.sharedInstance
    var startIdx = -1
    var endIdx = -1
    var locationArray: [String]!
    var locHelper = LocationHelper()

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func updateSelectedIdx() {
        if (self.locationArray.indexOf(self.ride.start_location) != nil) {
            self.startIdx = self.locationArray.indexOf(self.ride.start_location)!
        }
        if (self.locationArray.indexOf(self.ride.end_location) != nil) {
            self.endIdx = self.locationArray.indexOf(self.ride.end_location)!
        }
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let tag = PickerTag(rawValue: pickerView.tag) {
            switch tag {
            case PickerTag.NumSpotsPickerTag:
                return pickerData.count
            case PickerTag.StartLocPickerTag:
                return self.locHelper.getActualSize(LocationHelper.LocationPickerTag.StartLocPickerTag, startIdx: startIdx, endIdx: endIdx, locArrayLength: locationArray.count)
            case PickerTag.EndLocPickerTag:
                return self.locHelper.getActualSize(LocationHelper.LocationPickerTag.EndLocPickerTag, startIdx: self.startIdx, endIdx: self.endIdx, locArrayLength: self.locationArray.count)
            }
        }
        return 0
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let tag = PickerTag(rawValue: pickerView.tag) {
            switch tag {
            case PickerTag.NumSpotsPickerTag:
                return pickerData[row]
            case PickerTag.StartLocPickerTag:
                return self.locHelper.getActualString(LocationHelper.LocationPickerTag.StartLocPickerTag, row: row, startIdx: self.startIdx, endIdx: self.endIdx, locationArray: self.locationArray)
            case PickerTag.EndLocPickerTag:
                return self.locHelper.getActualString(LocationHelper.LocationPickerTag.EndLocPickerTag, row: row, startIdx: self.startIdx, endIdx: self.endIdx, locationArray: self.locationArray)
            }
        }
        return ""
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let tag = PickerTag(rawValue: pickerView.tag) {
            switch tag {
            case PickerTag.NumSpotsPickerTag:
                numSpotsField.text = pickerData[row]
                updateSave()
                self.numSpotsField.resignFirstResponder()
            case PickerTag.StartLocPickerTag:
                self.startIdx = self.locHelper.getActualRow(LocationHelper.LocationPickerTag.StartLocPickerTag, row: row, startIdx: self.startIdx, endIdx: self.endIdx)
                startLocField.text = locationArray[self.startIdx]
                updateSave()
                self.startLocField.resignFirstResponder()
            case PickerTag.EndLocPickerTag:
                self.endIdx = self.locHelper.getActualRow(LocationHelper.LocationPickerTag.EndLocPickerTag, row: row, startIdx: self.startIdx, endIdx: self.endIdx)
                endLocField.text = locationArray[self.endIdx]
                updateSave()
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
        updateSave()
    }

    func timePickerValueChanged() {
        print("Time Picker Value Changed");
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.NoStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        self.timeField.text = dateFormatter.stringFromDate(self.timePicker.date)
        updateSave()
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
    
    
    @IBAction func activeSwitch(sender: UISwitch) {
        if(sender.on){
            activePostLabel.textColor = UIColor.greenColor()
        }
        else {
            activePostLabel.textColor = UIColor(red: 0.765, green: 0.796, blue: 0.851, alpha: 1.0)
        }
    }

    func checkFieldsHaveValue() ->Bool {
        return ((self.startLocField.text != "") &&
                (self.endLocField.text != "") &&
                (self.dateField.text != "") &&
                (self.timeField.text != "") &&
                (self.numSpotsField.text != ""))
    }

    func updateSave() {
        if (checkFieldsHaveValue()) {
            self.saveButton.enabled = true
        } else {
            self.saveButton.enabled = false
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rideDataLoaded:",name:"rideDataFetched", object: nil)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.updateUI()
        
    }
    
    func rideDataLoaded(notification: NSNotification) {
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            // do some task
            dispatch_async(dispatch_get_main_queue()) {
                self.updateUI()
            }
        }

    }
    
    func updateUI() {
        self.ride = Ride.sharedInstance
        self.locationArray = self.ride.locations as! [String]
        print(self.ride.start_location)
        
        rideService = RideService()
        activeField.on = rideService.isRideActive()
        
        self.locations = self.ride.locations
        self.startLocField.text = self.ride.start_location
        self.endLocField.text = self.ride.end_location
        
        self.dateField.text = String(self.ride.date)
        self.timeField.text = String(self.ride.time)
        if (self.ride.spots == 0) {
            self.numSpotsField.text = ""
        } else {
            self.numSpotsField.text = String(self.ride.spots)
        }
        self.locationArray = self.ride.locations as! [String]
        
        updateSelectedIdx()
        updateSave()
    }
    
}

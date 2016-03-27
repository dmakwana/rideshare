//
//  SearchViewController.swift
//  rideshare
//
//  Created by Digvijay Makwana on 2016-03-25.
//  Copyright © 2016 Digvijay Makwana. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    enum PickerTag: Int {
        case StartLocPickerTag
        case EndLocPickerTag
    }

    @IBOutlet var startLocField: UITextField!
    @IBOutlet var endLocField: UITextField!
    @IBOutlet var dateField: UITextField!
    @IBOutlet var searchButton: UIButton!

    var ride = Ride.sharedInstance
    var startLocPicker: UIPickerView!
    var endLocPicker: UIPickerView!
    var datePicker: UIDatePicker!
    var startIdx = -1
    var endIdx = -1
    var locationArray: [String]!
    var locHelper = LocationHelper()
    
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

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let tag = PickerTag(rawValue: pickerView.tag) {
            switch tag {
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
            case PickerTag.StartLocPickerTag:
                self.startIdx = self.locHelper.getActualRow(LocationHelper.LocationPickerTag.StartLocPickerTag, row: row, startIdx: self.startIdx, endIdx: self.endIdx)
                startLocField.text = locationArray[self.startIdx]
                updateSearchButton()
                self.startLocField.resignFirstResponder()
            case PickerTag.EndLocPickerTag:
                self.endIdx = self.locHelper.getActualRow(LocationHelper.LocationPickerTag.EndLocPickerTag, row: row, startIdx: self.startIdx, endIdx: self.endIdx)
                endLocField.text = locationArray[self.endIdx]
                updateSearchButton()
                self.endLocField.resignFirstResponder()
            }
        }
    }
    
    func checkFieldsHaveValue() ->Bool {
        return ((self.startLocField.text != "") &&
            (self.endLocField.text != "") &&
            (self.dateField.text != ""))
    }
    
    func updateSearchButton() {
        if (checkFieldsHaveValue()) {
            self.searchButton.enabled = true
        } else {
            self.searchButton.enabled = false
        }
    }

    @IBAction func startLocEditing(sender: UITextField) {
        self.startLocPicker = UIPickerView()
        self.startLocPicker.tag = PickerTag.StartLocPickerTag.rawValue
        self.startLocField.inputView = self.startLocPicker
        self.startLocPicker.delegate = self
        self.startLocPicker.dataSource = self
    }

    @IBAction func endLocEditing(sender: UITextField) {
        self.endLocPicker = UIPickerView()
        self.endLocPicker.tag = PickerTag.EndLocPickerTag.rawValue
        self.endLocField.inputView = self.endLocPicker
        self.endLocPicker.delegate = self
        self.endLocPicker.dataSource = self
    }
    
    func datePickerValueChanged() {
        print("Date Picker Value Changed");
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        self.dateField.text = dateFormatter.stringFromDate(self.datePicker.date)
        updateSearchButton()
    }
    
    @IBAction func searchRides(sender: UIButton) {
        let rideService = RideService()
        rideService.searchRides(startLocField.text!, end_location: endLocField.text!, date: self.dateField.text!)
        
        let controller: DisplaySearchResultsViewController = DisplaySearchResultsViewController.init(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(controller, animated: false)
        //self.presentViewController(controller, animated: false) { () -> Void in
            //print("success")
        //}
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        self.locationArray = self.ride.locations as! [String]
        updateSearchButton()
    }
    
}
//
//  SearchViewController.swift
//  rideshare
//
//  Created by Digvijay Makwana on 2016-03-25.
//  Copyright © 2016 Digvijay Makwana. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet var dateField: UITextField!
    @IBOutlet var endLocField: UITextField!
    @IBOutlet var startLocField: UITextField!
    var datePicker: UIDatePicker!
    
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
    
    
}
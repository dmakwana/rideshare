//
//  DisplaySearchResultsViewController.swift
//  rideshare
//
//  Created by Supreet Singh on 2016-03-25.
//  Copyright © 2016 Digvijay Makwana. All rights reserved.
//

import UIKit
import MessageUI

class DisplaySearchResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate {
    
    var tableView: UITableView = UITableView()
    var items = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor(red: 237.0/255.0, green: 237.0/255.0, blue: 237.0/255.0, alpha: 1.0)
        self.view.backgroundColor = UIColor.blackColor()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "dataLoaded:",name:"ridesFetched", object: nil)
        
        self.tableView.registerClass(SearchResultCell.self, forCellReuseIdentifier: "resultCell")
        self.tableView.separatorStyle = .None
        self.tableView.allowsMultipleSelectionDuringEditing = false
        
        //let yPos: CGFloat! = (self.navigationController?.navigationBar.frame.height)! + UIApplication.sharedApplication().statusBarFrame.size.height
        self.tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.backgroundColor = UIColor.whiteColor()
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.view.addSubview(self.tableView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.topItem?.title = "Results"
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = nil
    }
    
    func dataLoaded(notification: NSNotification) {
        let jsonData = notification.object as! NSDictionary
        items = jsonData.valueForKey("rides") as! NSArray
        print(items.count)
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            // do some task
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: SearchResultCell = self.tableView.dequeueReusableCellWithIdentifier("resultCell") as! SearchResultCell
        let item = items[indexPath.section]
        let driver = item.valueForKey("driver") as! NSDictionary
        let ride = item.valueForKey("ride") as! NSDictionary
        
        cell.driverNameLabel.text = driver.valueForKey("full_name") as? String
        cell.startLabel.text = ride.valueForKey("start_location") as? String
        cell.endLabel.text = ride.valueForKey("end_location") as? String
        cell.dateLabel.text = ride.valueForKey("date") as? String
        cell.timeLabel.text = ride.valueForKey("time") as? String
        cell.setImageForCell(driver.valueForKey("profile_picture") as? String)
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        
        header.contentView.backgroundColor = UIColor.clearColor()
        header.textLabel?.textColor = UIColor.darkGrayColor()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = items[indexPath.section]
        let driver = item.valueForKey("driver") as! NSDictionary
        
        print(driver)
        let phone_number = driver.valueForKey("phone_number") as! String
        let email = driver.valueForKey("email") as! String
        
        if (phone_number != "" && MFMessageComposeViewController.canSendText()) {
            let composeVC = MFMessageComposeViewController()
            composeVC.messageComposeDelegate = self
        
            composeVC.recipients = [driver.valueForKey("phone_number") as! String]
            composeVC.body = "Hey, I saw your listing on RideShare. Do you still have spots available?"
            self.presentViewController(composeVC, animated: true, completion: nil)
        } else if (email != "" && MFMailComposeViewController.canSendMail()) {
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            
            composeVC.setToRecipients([email])
            composeVC.setSubject("RideShare Request")
            composeVC.setMessageBody("Hey, I saw your listing on RideShare. Do you still have spots available?", isHTML: true)
            self.presentViewController(composeVC, animated: true, completion: nil)
        }
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController,
        didFinishWithResult result: MessageComposeResult) {
            // Check the result or perform other tasks.
            
            // Dismiss the mail compose view controller.
            controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController,
        didFinishWithResult result: MFMailComposeResult, error: NSError?) {
            // Check the result or perform other tasks.
            
            // Dismiss the mail compose view controller.
            controller.dismissViewControllerAnimated(true, completion: nil)
    }

}



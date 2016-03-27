//
//  BaseViewController.swift
//  rideshare
//
//  Created by Supreet Singh on 2016-03-26.
//  Copyright © 2016 Digvijay Makwana. All rights reserved.
//

import UIKit
import SystemConfiguration

class BaseViewController: UIViewController {
    
    var banner: Banner!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "errorOccured:",name:"errorOccured", object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let yPos = UIApplication.sharedApplication().statusBarFrame.size.height
        banner = Banner(frame: CGRectMake(0.0, yPos, self.view.frame.width, 30.0))
        banner.hidden = true
        self.view.addSubview(banner)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if (self.navigationController?.navigationBar.hidden == false) {
            let yPos = (self.navigationController?.navigationBar.frame.height)! +  UIApplication.sharedApplication().statusBarFrame.size.height
            banner.frame.origin.y = yPos
        }
    }
    
    func showBannerWithText(text: String) {
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            // do some task
            dispatch_async(dispatch_get_main_queue()) {
                self.banner.hidden = false
                self.banner.textLabel.text = text
                self.banner.setHiddenAnimated(true)
            }
        }
    }
    
    func errorOccured(notification: NSNotification) {
        self.showBannerWithText("Something went wrong. Please try again later!")
    }
}

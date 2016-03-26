//
//  DisplaySearchResultsViewController.swift
//  rideshare
//
//  Created by Supreet Singh on 2016-03-25.
//  Copyright © 2016 Digvijay Makwana. All rights reserved.
//

import UIKit

class DisplaySearchResultsViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "dataLoaded:",name:"ridesFetched", object: nil)
        
    }
    
    func dataLoaded(notification: NSNotification) {
        let jsonData = notification.object as! NSDictionary
        print(jsonData)
    }
    
    
}



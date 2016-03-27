//
//  RideShareTabBarController.swift
//  rideshare
//
//  Created by Supreet Singh on 2016-03-26.
//  Copyright © 2016 Digvijay Makwana. All rights reserved.
//

import UIKit

class RideShareTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.lightGrayColor()
        self.selectedIndex = 0  // Show the Home View Controller First
        // let color = UIColor(red: 207.0/255.0, green: 5.0/255.0, blue: 5.0/255.0, alpha: 1.0)
        self.tabBar.barTintColor = UIColor.whiteColor()
        self.tabBar.tintColor = UIColor(red: 5.0/255.0, green: 26.0/255.0, blue: 44.0/255.0, alpha: 1)
    }
}

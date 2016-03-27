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
        self.tabBar.barTintColor = UIColor.whiteColor()
        self.tabBar.tintColor = UIColor(red: 5.0/255.0, green: 26.0/255.0, blue: 44.0/255.0, alpha: 1)
    }
}

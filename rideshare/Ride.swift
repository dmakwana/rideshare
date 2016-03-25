//
//  Ride.swift
//  rideshare
//
//  Created by Supreet Singh on 2016-03-25.
//  Copyright © 2016 Digvijay Makwana. All rights reserved.
//

import Foundation

class Ride: NSObject {
    
    static let sharedInstance = Ride()
    
    var ride_id = -1
    var driver_id = -1
    var start_location = ""
    var end_location = ""
    var date = ""
    var time = ""
    var spots = 0
    var active = true
    
    var locations = []
}
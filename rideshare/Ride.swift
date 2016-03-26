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
    var driver_id = ""
    var start_location = ""
    var end_location = ""
    var date = ""
    var time = ""
    var spots = 0
    var active = false
    
    var locations = []
    
    func updateRide(result: NSDictionary) {
        self.active = result.valueForKey("active") as! Bool
        self.date = result.valueForKey("date") as! String
        self.time = result.valueForKey("time") as! String
        self.driver_id = result.valueForKey("driver") as! String
        self.start_location = result.valueForKey("start_location") as! String
        self.end_location = result.valueForKey("end_location") as! String
        self.spots = result.valueForKey("spots") as! Int
        self.ride_id = result.valueForKey("ride_id") as! Int
    }
    
}
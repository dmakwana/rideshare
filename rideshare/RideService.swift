//
//  RideService.swift
//  rideshare
//
//  Created by Supreet Singh on 2016-03-25.
//  Copyright © 2016 Digvijay Makwana. All rights reserved.
//

import Foundation

class RideService: NSObject {
    
    
    func saveRide(start: String, end: String, date: String, time: String, spots: Int, active: Bool) {
        
        print("HELLPO")
        
        let ride = Ride.sharedInstance
        
        let url = NSURL(string: "http://rideshare.supreet.ca/ride/save/")
        let user = User.sharedInstance
        
        var ride_dict = Dictionary<String, AnyObject>()
        ride_dict["ride_id"] = ride.ride_id
        ride_dict["facebook_id"] = user.facebook_id
        ride_dict["start_location"] = start
        ride_dict["end_location"] = end
        ride_dict["date"] = date
        ride_dict["time"] = time
        ride_dict["spots"] = spots
        ride_dict["active"] = active
        print(ride_dict)
        
        var params = Dictionary<String, AnyObject>()
        params["ride_dict"] = ride_dict
        
        let request = NSMutableURLRequest(URL: url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        request.HTTPMethod = "POST"
        
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: .PrettyPrinted)
        } catch {
            print("Error while serializing params to POST Body")
        }
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            do {
                let result = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
                print(result)
                ride.updateRide(result!)
                                
            } catch {
                print("Error while parsing the result from HTTP POST request")
            }
        }
        
        task.resume()
    }
    
    func isRideActive() -> Bool {
        let ride = Ride.sharedInstance
        return ride.active
    }
    
    
    func getRideFromServer() {
        
        print("Get Ride from Server")
        let ride = Ride.sharedInstance
        
        let url = NSURL(string: "http://rideshare.supreet.ca/ride/fetch/")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) -> Void in
            do {
                let result = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
                print(result)
            } catch {
                print("Error while parsing the result from HTTP POST request")
            }
        }
        
        task.resume()
    }
    
    
    func getLocations() {
        
        let ride = Ride.sharedInstance
        
        let url = NSURL(string: "http://rideshare.supreet.ca/ride/locations/")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) -> Void in
            do {
                let result = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
                ride.locations = (result?.valueForKey("locations")) as! NSArray
                print(ride.locations)
            } catch {
                print("Error while parsing the result from HTTP POST request")
            }
        }
        
        task.resume()
        
    }


    
}
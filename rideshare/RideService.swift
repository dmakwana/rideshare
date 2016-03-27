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
            NSNotificationCenter.defaultCenter().postNotificationName("errorOccured", object: nil)
            return
        }
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            let httpResponse = response as? NSHTTPURLResponse
            if (httpResponse?.statusCode != 200) {
                NSNotificationCenter.defaultCenter().postNotificationName("errorOccured", object: nil)
                return
            }
            do {
                let result = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
                NSNotificationCenter.defaultCenter().postNotificationName("successfulPost", object: nil)
                ride.updateRide(result!)
                                
            } catch {
                print("Error while parsing the result from HTTP POST request")
                NSNotificationCenter.defaultCenter().postNotificationName("errorOccured", object: nil)
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
                ride.updateRide(result!)
                print(result)
            } catch {
                print("Error while parsing the result from HTTP POST request")
            }
        }
        
        task.resume()
    }
    
    
    
   
    func searchRides(start_location: String!, end_location: String!, date: String!) {
        
        let url = NSURL(string: "http://rideshare.supreet.ca/ride/search/")
        
        var search_dict = Dictionary<String, AnyObject>()
        search_dict["start_location"] = start_location
        search_dict["end_location"] = end_location
        search_dict["date"] = date
        
        var params = Dictionary<String, AnyObject>()
        params["search_dict"] = search_dict
        
        let request = NSMutableURLRequest(URL: url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        request.HTTPMethod = "POST"
        
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: .PrettyPrinted)
        } catch {
            print("Error while serializing params to POST Body")
            NSNotificationCenter.defaultCenter().postNotificationName("errorOccured", object: nil)
            return
        }
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            let httpResponse = response as? NSHTTPURLResponse
            if (httpResponse?.statusCode != 200) {
                NSNotificationCenter.defaultCenter().postNotificationName("errorOccured", object: nil)
                return
            }
            do {
                let result = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
                NSNotificationCenter.defaultCenter().postNotificationName("ridesFetched", object: result)
                //print(result)
                
            } catch {
                print("Error while parsing the result from HTTP POST request")
                NSNotificationCenter.defaultCenter().postNotificationName("errorOccured", object: nil)
            }
        }
        
        print("Searching rides")
        task.resume()

    }

    func getLocations() -> NSArray {
        
        let ride = Ride.sharedInstance
        
        let url = NSURL(string: "http://rideshare.supreet.ca/ride/locations/")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) -> Void in
            let httpResponse = response as? NSHTTPURLResponse
            if (httpResponse?.statusCode != 200) {
                NSNotificationCenter.defaultCenter().postNotificationName("errorOccured", object: nil)
                return
            }
            do {
                let result = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
                ride.locations = (result?.valueForKey("locations")) as! NSArray
                NSNotificationCenter.defaultCenter().postNotificationName("rideDataFetched", object: nil)
            } catch {
                print("Error while parsing the result from HTTP POST request")
                NSNotificationCenter.defaultCenter().postNotificationName("errorOccured", object: nil)
            }
        }
        
        task.resume()
        return ride.locations
        
    }


    
}

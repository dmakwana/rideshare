//
//  RideService.swift
//  rideshare
//
//  Created by Supreet Singh on 2016-03-25.
//  Copyright © 2016 Digvijay Makwana. All rights reserved.
//

import Foundation

class RideService: NSObject {
    
    func createNewRide(start: String, end: String, date: String, time: String, spots: String, active: Bool) {
        
        let url = NSURL(string: "http://rideshare.supreet.ca/ride/new/")
        let user = User.sharedInstance
        
        var ride_dict = Dictionary<String, AnyObject>()
        ride_dict["facebook_id"] = user.facebook_id
        ride_dict["start_location"] = start
        ride_dict["end_location"] = end
        ride_dict["date"] = date
        ride_dict["time"] = time
        ride_dict["spots"] = spots
        ride_dict["active"] = active
        
        var params = Dictionary<String, AnyObject>()
        params["ride_dict"] = ride_dict
        
        sendPOSTRequestWithParams(url!, params: params)
    }
    
    func sendPOSTRequestWithParams(url: NSURL, params: Dictionary<String, AnyObject>) {
        
        
        let request = NSMutableURLRequest(URL: url)
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
            } catch {
                print("Error while parsing the result from HTTP POST request")
            }
        }
        
        task.resume()
    }


    
}
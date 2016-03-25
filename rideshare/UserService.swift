//
//  UserService.swift
//  rideshare
//
//  Created by Supreet Singh on 2016-03-25.
//  Copyright © 2016 Digvijay Makwana. All rights reserved.
//

import Foundation

class UserService: NSObject {
    
    
    func loginUserWithBackend() {
        let user = User.sharedInstance
        
        var params = Dictionary<String, AnyObject>()
        params["login_dict"] = user.getLoginDict()

        
        let url = NSURL(string: "http://rideshare.supreet.ca/user/login/")
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
            } catch {
                print("Error while parsing the result from HTTP POST request")
            }
        }

        task.resume()
    }
 
}

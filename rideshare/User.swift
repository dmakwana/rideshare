//
//  User.swift
//  rideshare
//
//  Created by Supreet Singh on 2016-03-25.
//  Copyright © 2016 Digvijay Makwana. All rights reserved.
//

import Foundation

class User {
    
    static let sharedInstance = User()
    var facebook_id = ""
    var access_token = ""
    var full_name = ""
    var profile_picture = ""
    var phone_number = ""
    var email = ""
    var car_name = ""
    
    init() {
        print("User initiated");
    }
    
    func getLoginDict() -> Dictionary<String, String>{
        var dict = Dictionary<String, String>()
        dict["facebook_id"] = facebook_id
        dict["access_token"] = access_token
        dict["full_name"] = full_name
        dict["profile_picture"] = profile_picture
        dict["phone_number"] = phone_number
        dict["email"] = email
        dict["car_name"] = car_name
        return dict
    }
    
    func updateUser(result: NSDictionary) {
        print("User.updateUser()")
        print(result)
        self.phone_number = result.valueForKey("phone_number") as! String
        self.car_name = result.valueForKey("car_name") as! String
    }
    
    func clear() {
        facebook_id = ""
        access_token = ""
        full_name = ""
        profile_picture = ""
        phone_number = ""
        email = ""
        car_name = ""
    }
}

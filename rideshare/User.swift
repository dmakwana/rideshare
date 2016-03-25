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
    
}

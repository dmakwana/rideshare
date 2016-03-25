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
    
}

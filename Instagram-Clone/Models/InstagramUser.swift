//
//  InstagramUser.swift
//  Instagram-Clone
//
//  Created by Inam Ahmad-zada on 2018-01-10.
//  Copyright © 2018 Inam Ahmad-zada. All rights reserved.
//

import Foundation

struct InstagramUser {
    var username: String
    var imageUrl: String
    
    init(dictionary: [String: Any]) {
        username = dictionary["username"] as? String ?? ""
        imageUrl = dictionary["imageUrl"] as? String ?? ""
    }
}

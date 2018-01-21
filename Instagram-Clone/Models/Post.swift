//
//  Post.swift
//  Instagram-Clone
//
//  Created by Inam Ahmad-zada on 2018-01-10.
//  Copyright © 2018 Inam Ahmad-zada. All rights reserved.
//

import Foundation

struct Post {
    let imageUrl: String
    let user: InstagramUser
    let caption: String
    let creationDate: Date
    
    init(user: InstagramUser, dictionary: [String:Any]) {
        self.user = user
        self.caption = dictionary["caption"] as? String ?? ""
        imageUrl = dictionary["imageUrl"] as? String ?? ""
        
        let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
        creationDate = Date(timeIntervalSince1970: secondsFrom1970)
    }
}

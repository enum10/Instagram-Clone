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
    
    init(user: InstagramUser, dictionary: [String:Any]) {
        self.user = user
        self.caption = dictionary["caption"] as? String ?? ""
        imageUrl = dictionary["imageUrl"] as? String ?? ""
    }
}

//
//  FirebaseExtensions.swift
//  Instagram-Clone
//
//  Created by Inam Ahmad-zada on 2018-01-11.
//  Copyright © 2018 Inam Ahmad-zada. All rights reserved.
//

import Foundation
import Firebase

extension Database {
    static func fetchUserWithUID(_ uid: String, completion: @escaping (InstagramUser) -> ()) {
        self.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let userDictionary = snapshot.value as? [String:Any] else { return }
            let user = InstagramUser(uid: uid, dictionary: userDictionary)
            completion(user)
        }) { (error) in
            print("Error while downloading user in HomeController: ", error)
        }
    }
}

//
//  UserProfileController.swift
//  Instagram-Clone
//
//  Created by Inam Ahmad-zada on 2018-01-08.
//  Copyright © 2018 Inam Ahmad-zada. All rights reserved.
//

import UIKit
import Firebase

class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        
        fetchUserData()
    }
    
    func fetchUserData() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any], let username = dictionary["username"] as? String else { return }
            self?.navigationItem.title = username
        }) { (error) in
            print("Error getting user data in UserProfileController: ", error)
        }
    }
}

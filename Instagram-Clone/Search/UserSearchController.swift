//
//  UserSearchController.swift
//  Instagram-Clone
//
//  Created by Inam Ahmad-zada on 2018-01-13.
//  Copyright © 2018 Inam Ahmad-zada. All rights reserved.
//

import UIKit

class UserSearchController: UICollectionViewController {
    
    let cellId = "cellId"
    
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "Enter username"
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        navigationItem.titleView = searchBar
    }
}

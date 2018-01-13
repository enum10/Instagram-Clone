//
//  UserSearchCell.swift
//  Instagram-Clone
//
//  Created by Inam Ahmad-zada on 2018-01-13.
//  Copyright © 2018 Inam Ahmad-zada. All rights reserved.
//

import UIKit

class UserSearchCell: UICollectionViewCell {
    
    let userImageView: CustomImageView = {
        let view = CustomImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
//        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        view.backgroundColor = .red
        return view
    }()
    
    let usernameLabel: UILabel = {
        let view = UILabel()
        view.text = "Username"
        view.font = UIFont.boldSystemFont(ofSize: 14)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(userImageView)
        addSubview(usernameLabel)
        userImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, topPadding: 8, leftPadding: 8, bottomPadding: 8, rightPadding: 0, width: 50, height: 0)
        userImageView.layer.cornerRadius = 50 / 2
        usernameLabel.anchor(top: userImageView.topAnchor, left: userImageView.rightAnchor, bottom: userImageView.bottomAnchor, right: rightAnchor, topPadding: 0, leftPadding: 8, bottomPadding: 0, rightPadding: 8, width: 0, height: 0)
        
        let seperator = UIView()
        seperator.backgroundColor = UIColor(white: 0, alpha: 0.5)
        addSubview(seperator)
        seperator.anchor(top: nil, left: usernameLabel.leftAnchor, bottom: bottomAnchor, right: rightAnchor, topPadding: 0, leftPadding: 0, bottomPadding: 0, rightPadding: 0, width: 0, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

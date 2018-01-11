//
//  HomePostCell.swift
//  Instagram-Clone
//
//  Created by Inam Ahmad-zada on 2018-01-10.
//  Copyright © 2018 Inam Ahmad-zada. All rights reserved.
//

import UIKit

class HomePostCell: UICollectionViewCell {
    
    var post: Post? {
        didSet {
            guard let imageUrl = post?.imageUrl else { return }
            imageView.loadImage(with: imageUrl)
        }
    }
    
    let userProfileImageView: CustomImageView = {
        let view = CustomImageView()
        view.backgroundColor = .blue
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        return view
    }()
    
    let optionsButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("•••", for: .normal)
        view.setTitleColor(.black, for: .normal)
        return view
    }()
    
    let usernameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 14)
        view.text = "Username"
        return view
    }()
    
    let imageView: CustomImageView = {
        let view = CustomImageView()
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let likeButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(#imageLiteral(resourceName: "like_unselected").withRenderingMode(.alwaysOriginal), for: .normal)
        return view
    }()
    
    let commentButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(#imageLiteral(resourceName: "comment").withRenderingMode(.alwaysOriginal), for: .normal)
        return view
    }()
    
    let sendButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(#imageLiteral(resourceName: "send2").withRenderingMode(.alwaysOriginal), for: .normal)
        return view
    }()
    
    let bookmarkButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(#imageLiteral(resourceName: "ribbon").withRenderingMode(.alwaysOriginal), for: .normal)
        return view
    }()
    
    let captionAndTimeLabel: UILabel = {
        let view = UILabel()
        let attributedText = NSMutableAttributedString(string: "Username", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "  Building Instagram application clone from scratch to add this project to Github", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]))
        attributedText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 4)]))
        attributedText.append(NSAttributedString(string: "1 week ago", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.gray]))
        view.attributedText = attributedText
        view.numberOfLines = 0
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(userProfileImageView)
        addSubview(optionsButton)
        addSubview(usernameLabel)
        addSubview(imageView)
        
        userProfileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, topPadding: 8, leftPadding: 8, bottomPadding: 0, rightPadding: 0, width: 40, height: 40)
        userProfileImageView.layer.cornerRadius = 40 / 2
        
        optionsButton.anchor(top: topAnchor, left: nil, bottom: imageView.topAnchor, right: rightAnchor, topPadding: 0, leftPadding: 0, bottomPadding: 0, rightPadding: 0, width: 44, height: 0)
        
        usernameLabel.anchor(top: userProfileImageView.topAnchor, left: userProfileImageView.rightAnchor, bottom: userProfileImageView.bottomAnchor, right: optionsButton.leftAnchor, topPadding: 0, leftPadding: 8, bottomPadding: 0, rightPadding: 0, width: 0, height: 0)
        
        imageView.anchor(top: userProfileImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topPadding: 8, leftPadding: 0, bottomPadding: 0, rightPadding: 0, width: 0, height: 0)
        imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        
        setupActionButtons()
        
        addSubview(captionAndTimeLabel)
        captionAndTimeLabel.anchor(top: likeButton.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topPadding: 0, leftPadding: 8, bottomPadding: 0, rightPadding: 8, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupActionButtons() {
        let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, sendButton])
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.anchor(top: imageView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, topPadding: 0, leftPadding: 8, bottomPadding: 0, rightPadding: 0, width: 120, height: 50)
        
        addSubview(bookmarkButton)
        bookmarkButton.anchor(top: imageView.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, topPadding: 0, leftPadding: 0, bottomPadding: 0, rightPadding: 0, width: 40, height: 50)
    }
}

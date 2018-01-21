//
//  UserProfileHeader.swift
//  Instagram-Clone
//
//  Created by Inam Ahmad-zada on 2018-01-08.
//  Copyright © 2018 Inam Ahmad-zada. All rights reserved.
//

import UIKit
import Firebase

class UserProfilerHeader: UICollectionViewCell {
    
    var user: InstagramUser? {
        didSet {
            guard let profileImageUrlString = user?.imageUrl else { return }
            userImageView.loadImage(with: profileImageUrlString)
            usernameLabel.text = user?.username
            setEditProfileFollowButton()
        }
    }
    
    fileprivate func setEditProfileFollowButton() {
        guard let currentlySignedInUserUID = Auth.auth().currentUser?.uid else { return }
        guard let userId = user?.uid else { return }
        
        if currentlySignedInUserUID == userId {
            
        } else {
            let ref = Database.database().reference().child("following").child(currentlySignedInUserUID).child(userId)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                if let value = snapshot.value as? Int, value == 1 {
                    DispatchQueue.main.async {
                        self.editProfileFollowButton.setTitle("Unfollow", for: .normal)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.editProfileFollowButton.setTitle("Follow", for: .normal)
                        self.editProfileFollowButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
                        self.editProfileFollowButton.setTitleColor(.white, for: .normal)
                        self.editProfileFollowButton.layer.borderColor = UIColor(white: 0, alpha: 0.2).cgColor
                    }
                }
            }, withCancel: { (err) in
                print("Failed to check if following: ", err)
            })
        }
    }
    
    @objc
    func editProfileFollowButtonAction() {
        guard let currentlySignedInUserUID = Auth.auth().currentUser?.uid else { return }
        guard let userId = user?.uid else { return }
        
        if editProfileFollowButton.title(for: .normal) == "Unfollow" {
            Database.database().reference().child("following").child(currentlySignedInUserUID).child(userId).removeValue(completionBlock: { (err, ref) in
                if let err = err {
                    print("Error while unfollow: ", err)
                    return
                }
                DispatchQueue.main.async {
                    self.editProfileFollowButton.setTitle("Follow", for: .normal)
                    self.editProfileFollowButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
                    self.editProfileFollowButton.setTitleColor(.white, for: .normal)
                    self.editProfileFollowButton.layer.borderColor = UIColor(white: 0, alpha: 0.2).cgColor
                }
            })
        } else {
            let ref = Database.database().reference().child("following").child(currentlySignedInUserUID)
            let values = [userId: 1]
            ref.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if let err = err {
                    print("Error while follow: ", err)
                    return
                }
                DispatchQueue.main.async {
                    self.editProfileFollowButton.setTitle("Unfollow", for: .normal)
                    self.editProfileFollowButton.setTitleColor(.black, for: .normal)
                    self.editProfileFollowButton.backgroundColor = .white
                }
            })
        }
    }
    
    let userImageView: CustomImageView = {
        let view = CustomImageView()
        return view
    }()
    
    let gridButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        return view
    }()
    
    let listButton: UIButton = {
        let view = UIButton(type: .system)
        view.tintColor = UIColor(white: 0, alpha: 0.2)
        view.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        return view
    }()
    
    let bookmarkButton: UIButton = {
        let view = UIButton(type: .system)
        view.tintColor = UIColor(white: 0, alpha: 0.2)
        view.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        return view
    }()
    
    let postsLabel: UILabel = {
        let view = UILabel()
        let attributedText = NSMutableAttributedString(string: "11\n", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "posts", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.lightGray]))
        view.attributedText = attributedText
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    let followersLabel: UILabel = {
        let view = UILabel()
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "followers", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.lightGray]))
        view.attributedText = attributedText
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    let followingLabel: UILabel = {
        let view = UILabel()
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "following", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.lightGray]))
        view.attributedText = attributedText
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    lazy var editProfileFollowButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Edit Profile", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 5
        view.addTarget(self, action: #selector(editProfileFollowButtonAction), for: .touchUpInside)
        return view
    }()
    
    let usernameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.boldSystemFont(ofSize: 14)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(userImageView)
        userImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, topPadding: 12, leftPadding: 12, bottomPadding: 0, rightPadding: 0, width: 80, height: 80)
        userImageView.layer.cornerRadius = 80 / 2
        userImageView.clipsToBounds = true
        
        setupBottomToolbar()
        setupUserStats()
        addSubview(editProfileFollowButton)
        editProfileFollowButton.anchor(top: postsLabel.bottomAnchor, left: postsLabel.leftAnchor, bottom: nil, right: followingLabel.rightAnchor, topPadding: 2, leftPadding: 0, bottomPadding: 0, rightPadding: 0, width: 0, height: 34)
        addSubview(usernameLabel)
        usernameLabel.anchor(top: editProfileFollowButton.bottomAnchor, left: leftAnchor, bottom: gridButton.topAnchor, right: rightAnchor, topPadding: 3, leftPadding: 12, bottomPadding: 0, rightPadding: 12, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupBottomToolbar() {
        let stackView = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topPadding: 0, leftPadding: 0, bottomPadding: 0, rightPadding: 0, width: 0, height: 50)
        
        let topBorder = UIView()
        topBorder.backgroundColor = .lightGray
        
        let bottomBorder = UIView()
        bottomBorder.backgroundColor = .lightGray
        
        addSubview(topBorder)
        addSubview(bottomBorder) 
        topBorder.anchor(top: stackView.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topPadding: 0, leftPadding: 0, bottomPadding: 0, rightPadding: 0, width: 0, height: 0.5)
        bottomBorder.anchor(top: nil, left: leftAnchor, bottom: stackView.bottomAnchor, right: rightAnchor, topPadding: 0, leftPadding: 0, bottomPadding: 0, rightPadding: 0, width: 0, height: 0.5)
    }
    
    fileprivate func setupUserStats() {
        let stackView = UIStackView(arrangedSubviews: [postsLabel, followersLabel, followingLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: userImageView.rightAnchor, bottom: nil, right: rightAnchor, topPadding: 12, leftPadding: 12, bottomPadding: 0, rightPadding: 12, width: 0, height: 50)
    }
}

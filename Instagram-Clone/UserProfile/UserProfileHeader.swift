//
//  UserProfileHeader.swift
//  Instagram-Clone
//
//  Created by Inam Ahmad-zada on 2018-01-08.
//  Copyright © 2018 Inam Ahmad-zada. All rights reserved.
//

import UIKit

class UserProfilerHeader: UICollectionViewCell {
    
    var user: InstagramUser? {
        didSet {
            setupProfileImage()
        }
    }
    
    let userImageView: UIImageView = {
        let view = UIImageView()
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
    
    let editProfileButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Edit Profile", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 5
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
        addSubview(editProfileButton)
        editProfileButton.anchor(top: postsLabel.bottomAnchor, left: postsLabel.leftAnchor, bottom: nil, right: followingLabel.rightAnchor, topPadding: 2, leftPadding: 0, bottomPadding: 0, rightPadding: 0, width: 0, height: 34)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupProfileImage() {
        guard let profileImageUrlString = user?.imageUrl, let url = URL(string: profileImageUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            if let error = error {
                print("Error downloading user image: ", error)
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.userImageView.image = image
            }
        }.resume()
    }
    
    fileprivate func setupBottomToolbar() {
        let stackView = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topPadding: 0, leftPadding: 0, bottomPadding: 0, rightPadding: 0, width: 0, height: 50)
    }
    
    fileprivate func setupUserStats() {
        let stackView = UIStackView(arrangedSubviews: [postsLabel, followersLabel, followingLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: userImageView.rightAnchor, bottom: nil, right: rightAnchor, topPadding: 12, leftPadding: 12, bottomPadding: 0, rightPadding: 12, width: 0, height: 50)
    }
}

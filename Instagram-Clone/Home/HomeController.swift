//
//  HomeController.swift
//  Instagram-Clone
//
//  Created by Inam Ahmad-zada on 2018-01-10.
//  Copyright © 2018 Inam Ahmad-zada. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo2"))
        collectionView?.backgroundColor = .white
        collectionView?.register(HomePostCell.self, forCellWithReuseIdentifier: cellId)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
        fetchAllPosts()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePostCell
        cell.post = posts[indexPath.item]
        return cell
    }
    
    func fetchAllPosts() {
        fetchMyPosts()
        fetchFollowingUserIDs()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 8 + 40 + 8
        height += view.frame.size.width
        height += 50
        height += 60
        return CGSize(width: view.frame.size.width, height: height)
    }
    
    @objc
    func handleRefresh() {
        posts.removeAll()
        fetchAllPosts()
    }
    
    fileprivate func fetchMyPosts() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.fetchUserWithUID(uid) { (user) in
            self.fetchPostsWithUser(user: user)
        }
    }
    
    fileprivate func fetchFollowingUserIDs() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("following").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let userIDsDictionary = snapshot.value as? [String:Any] else { return }
            userIDsDictionary.forEach({ (key, value) in
                Database.fetchUserWithUID(key, completion: { (user) in
                    self.fetchPostsWithUser(user: user)
                })
            })
        }) { (err) in
            print("Error while fetching following user posts: ", err)
        }
    }
    
    fileprivate func fetchPostsWithUser(user: InstagramUser) {
        let ref = Database.database().reference().child("posts").child(user.uid)
        ref.observeSingleEvent(of: .value, with: {[weak self] (snapshot) in
            guard let dictionaries = snapshot.value as? [String:Any] else { return }
            self?.collectionView?.refreshControl?.endRefreshing()
            dictionaries.forEach({ (key, value) in
                guard let dictionary = value as? [String:Any] else { return }
                let post = Post(user: user, dictionary: dictionary)
                self?.posts.append(post)
            })
            self?.posts.sort(by: { (post1, post2) -> Bool in
                return post1.creationDate.compare(post2.creationDate) == .orderedDescending
            })
            self?.collectionView?.reloadData()
        }) { (error) in
            print("Error while downloading posts in home controller")
        }
    }
}

//
//  SharePhotoController.swift
//  Instagram-Clone
//
//  Created by Inam Ahmad-zada on 2018-01-10.
//  Copyright © 2018 Inam Ahmad-zada. All rights reserved.
//

import UIKit
import Firebase

class SharePhotoController: UIViewController {
    
    static let updateNotificationName = Notification.Name("updateFeed")
    
    var selectedImage: UIImage? {
        didSet {
            self.imageView.image = selectedImage
        }
    }
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let textView: UITextView = {
        let view = UITextView()
        view.font = UIFont.systemFont(ofSize: 14)
        return view
    }()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        setupNavigationButtons()
        setupImageAndTextFields()
    }
    
    fileprivate func setupNavigationButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(shareAction))
    }
    
    fileprivate func setupImageAndTextFields() {
        let containerView = UIView()
        containerView.backgroundColor = .white
        view.addSubview(containerView)
        containerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topPadding: 0, leftPadding: 0, bottomPadding: 0, rightPadding: 0, width: 0, height: 100)
        
        containerView.addSubview(imageView)
        imageView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: nil, topPadding: 8, leftPadding: 8, bottomPadding: 8, rightPadding: 0, width: 0, height: 0)
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1).isActive = true
        
        containerView.addSubview(textView)
        textView.anchor(top: containerView.topAnchor, left: imageView.rightAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, topPadding: 0, leftPadding: 4, bottomPadding: 0, rightPadding: 4, width: 0, height: 0)
    }
    
    @objc
    func shareAction() {
        guard let image = selectedImage, let imageData = UIImageJPEGRepresentation(image, 0.7) else { return }
        navigationItem.rightBarButtonItem?.isEnabled = false
        let filename = NSUUID().uuidString
        Storage.storage().reference().child("posts").child(filename).putData(imageData, metadata: nil) {[weak self] (metadata, error) in
            if let err = error {
                self?.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Error while saving post image to database: ", err)
                return
            }
            
            guard let imageUrl = metadata?.downloadURL()?.absoluteString else { return }
            self?.savePostToDatabase(with: imageUrl)
        }
    }
    
    func savePostToDatabase(with imageUrl: String) {
        guard let postImage = selectedImage else { return }
        guard let caption = textView.text else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let userPostRef = Database.database().reference().child("posts").child(uid)
        let ref = userPostRef.childByAutoId()
        let values = ["imageUrl": imageUrl, "caption": caption, "imageWidth": postImage.size.width, "imageHeight": postImage.size.height, "creationDate": Date().timeIntervalSince1970] as [String : Any]
        ref.updateChildValues(values) {[weak self] (error, ref) in
            if let err = error {
                self?.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Error while saving post to database: ", err)
                return
            }
            
            self?.dismiss(animated: true, completion: nil)
            
            NotificationCenter.default.post(name: SharePhotoController.updateNotificationName, object: nil)
        }
    }
}

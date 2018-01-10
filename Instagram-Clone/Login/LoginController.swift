//
//  LoginController.swift
//  Instagram-Clone
//
//  Created by Inam Ahmad-zada on 2018-01-09.
//  Copyright © 2018 Inam Ahmad-zada. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    let logoContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 0, green: 120, blue: 175)
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        imageView.anchor(top: nil, left: nil, bottom: nil, right: nil, topPadding: 0, leftPadding: 0, bottomPadding: 0, rightPadding: 0, width: 200, height: 50)
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return view
    }()
    
    let signUpButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Don't have an account? Sign up", for: .normal)
        view.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        return view
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        view.backgroundColor = .white
        view.addSubview(logoContainerView)
        logoContainerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topPadding: 0, leftPadding: 0, bottomPadding: 0, rightPadding: 0, width: 0, height: 180)
        view.addSubview(signUpButton)
        signUpButton.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topPadding: 0, leftPadding: 0, bottomPadding: 0, rightPadding: 0, width: 0, height: 50)
    }
    
    @objc
    func signUpAction() {
        let signUpController = SignUpController()
        self.navigationController?.pushViewController(signUpController, animated: true)
    }
}

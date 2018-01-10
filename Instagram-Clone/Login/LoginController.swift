//
//  LoginController.swift
//  Instagram-Clone
//
//  Created by Inam Ahmad-zada on 2018-01-09.
//  Copyright © 2018 Inam Ahmad-zada. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    let signUpButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Don't have an account? Sign up", for: .normal)
        view.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        view.backgroundColor = .white
        view.addSubview(signUpButton)
        signUpButton.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topPadding: 0, leftPadding: 0, bottomPadding: 0, rightPadding: 0, width: 0, height: 50)
    }
    
    @objc
    func signUpAction() {
        let signUpController = SignUpController()
        self.navigationController?.pushViewController(signUpController, animated: true)
    }
}

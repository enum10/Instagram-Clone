//
//  PreviewPhotoContainerView.swift
//  Instagram-Clone
//
//  Created by Inam Ahmad-zada on 2018-01-24.
//  Copyright © 2018 Inam Ahmad-zada. All rights reserved.
//

import UIKit

class PreviewPhotoContainerView: UIView {
    
    let previewImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    lazy var cancelButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(#imageLiteral(resourceName: "cancel_shadow").withRenderingMode(.alwaysOriginal), for: .normal)
        view.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        return view
    }()
    
    lazy var saveButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(#imageLiteral(resourceName: "save_shadow").withRenderingMode(.alwaysOriginal), for: .normal)
        view.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(previewImageView)
        addSubview(cancelButton)
        addSubview(saveButton)
        previewImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topPadding: 0, leftPadding: 0, bottomPadding: 0, rightPadding: 0, width: 0, height: 0)
        cancelButton.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, topPadding: 12, leftPadding: 12, bottomPadding: 0, rightPadding: 0, width: 50, height: 50)
        saveButton.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, topPadding: 0, leftPadding: 12, bottomPadding: 24, rightPadding: 0, width: 50, height: 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func cancelAction() {
        self.removeFromSuperview()
    }
    
    @objc
    func saveAction() {
        
    }
}

//
//  CustomImageView.swift
//  Instagram-Clone
//
//  Created by Inam Ahmad-zada on 2018-01-10.
//  Copyright © 2018 Inam Ahmad-zada. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
    var lastUrlStringUsedToLoad: String?
    var imageCache = [String:UIImage]()
    
    func loadImage(with urlString: String) {
        lastUrlStringUsedToLoad = urlString
        
        if let cachedImage = imageCache[urlString] {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
            if let error = error {
                print("Error while downloading image in UserProfilePhotoCell: ", error)
                return
            }
            
            if url.absoluteString != self!.lastUrlStringUsedToLoad {
                return
            }
            
            guard let imageData = data else { return }
            let image = UIImage(data: imageData)
            self?.imageCache[url.absoluteString] = image
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }.resume()
    }
}

//
//  Extensions + UIImageView.swift
//  RedditDemo
//
//  Created by Valerii Melnykov on 25.10.2020.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadThumbnail(urlSting: String) {
        guard let url = URL(string: urlSting) else { return }
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlSting as AnyObject) {
            image = imageFromCache as? UIImage
            return
        }
        NetworkManager.downloadImage(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                guard let imageToCache = UIImage(data: data) else { return }
                imageCache.setObject(imageToCache, forKey: urlSting as AnyObject)
                self.image = UIImage(data: data)
            case .failure(_):
                DispatchQueue.main.async {
                    self.image = UIImage()
                }
                
            }
        }
    }
}

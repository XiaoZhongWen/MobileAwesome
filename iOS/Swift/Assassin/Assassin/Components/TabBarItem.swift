//
//  TabBarItem.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/6/3.
//

import UIKit
import Kingfisher

class TabBarItem: UITabBarItem {
    init(title: String?, imageUrl: String?, selectedImageUrl: String?) {
        super.init()
        self.title = title

        if let str = imageUrl, let url = URL.init(string: str) {
            ImageDownloader.default.downloadImage(with: url, retrieveImageTask: RetrieveImageTask.empty, options: [.cacheOriginalImage], progressBlock: nil) { (image, error, url, data) in
                self.image = image
            }
        }

        if let str = selectedImageUrl, let url = URL.init(string: str) {
            ImageDownloader.default.downloadImage(with: url, retrieveImageTask: RetrieveImageTask.empty, options: [.cacheOriginalImage], progressBlock: nil) { (image, error, url, data) in
                self.selectedImage = image
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

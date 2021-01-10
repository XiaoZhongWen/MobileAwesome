//
//  ImageService.swift
//  Assassin-Native
//
//  Created by 肖仲文 on 2021/1/9.
//  Copyright © 2021 肖仲文. All rights reserved.
//

import Kingfisher

class ImageService {
    private var imageDownloader = ImageDownloader.default
    private var pathForCacheImage: String = {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/cacheImage"
        return path
    }()
    
    static let shared = ImageService()
    
    private init() {}
    
    func download(url: String, completion: @escaping (UIImage?) -> Void) {
        if let downloadUrl = URL.init(string: url) {
            imageDownloader.downloadImage(with: downloadUrl, options: [.cacheMemoryOnly]) { [weak self] result in
                switch result {
                case let .success(imageLoadingResult):
                    self?.save(image: imageLoadingResult.image, identifier: url.md5)
                    completion(imageLoadingResult.image)
                case let .failure(kingfisherError):
                    print(kingfisherError.errorDescription ?? "download image failure. url: \(url)")
                }
            }
        } else {
            completion(nil)
        }
    }
    
    func save(image: UIImage, identifier: String) {
        if let url = URL.init(string: pathForCacheImage) {
            do {
                try image.pngData()?.write(to: url, options: .atomic)
            } catch {
                print("save image failure.")
            }
        }
    }
    
    func cacheImage(for identifier: String) -> UIImage? {
        if let url = URL.init(string: (pathForCacheImage + identifier)) {
            if let data = try? Data.init(contentsOf: url) {
                return UIImage.init(data: data)
            }
        }
        return nil
    }
}

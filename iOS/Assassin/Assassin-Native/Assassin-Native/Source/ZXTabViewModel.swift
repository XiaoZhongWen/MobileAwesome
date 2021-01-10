//
//  ZXTabViewModel.swift
//  Assassin-Native
//
//  Created by 肖仲文 on 2021/1/10.
//  Copyright © 2021 肖仲文. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class ZXTabViewModel {
    var icon: Single<UIImage>?
    var selectedIcon: Single<UIImage>?
    
    init(iconUrl: String?, selectedIconUrl: String?) {
        if let url = iconUrl {
            icon = Single.create { single in
                if let icon = ImageService.shared.cacheImage(for: url.md5) {
                    single(.success(icon))
                } else {
                    ImageService.shared.download(url: url) { image in
                        if let icon = image {
                            single(.success(icon))
                        } else {
                            single(.error(AssassinError.urlInvalidError))
                        }
                    }
                }
                return Disposables.create()
            }
        }
        
        if let url = selectedIconUrl {
            selectedIcon = Single.create { single in
                if let icon = ImageService.shared.cacheImage(for: url.md5) {
                    single(.success(icon))
                } else {
                    ImageService.shared.download(url: url) { image in
                        if let icon = image {
                            single(.success(icon))
                        } else {
                            single(.error(AssassinError.urlInvalidError))
                        }
                    }
                }
                return Disposables.create()
            }
        }
    }
}

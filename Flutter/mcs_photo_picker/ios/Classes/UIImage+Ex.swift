//
//  UIImage+Ex.swift
//  mcs_photo_picker
//
//  Created by 肖仲文 on 2022/3/30.
//

import Foundation

extension UIImage {
    func reRenderImage(width: Int, height: Int) -> UIImage? {
        let size = CGSize.init(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        draw(in: CGRect.init(x: 0, y: 0, width: width, height: height))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}

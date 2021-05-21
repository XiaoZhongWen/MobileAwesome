//
//  UIImage+Assassin.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/5/21.
//

import UIKit

extension UIImage {
    func withCorner(_ radius: CGFloat) -> UIImage? {
        let rect = CGRect.init(origin: CGPoint.zero, size: self.size)
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        let path = UIBezierPath.init(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: CGSize.init(width: radius, height: radius))
        path.addClip()
        self.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}

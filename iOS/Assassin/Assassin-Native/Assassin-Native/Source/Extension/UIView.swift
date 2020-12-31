//
//  UIView.swift
//  Assassin-Native
//
//  Created by 肖仲文 on 2020/12/30.
//  Copyright © 2020 肖仲文. All rights reserved.
//

import UIKit

extension UIView {
    /// 视图添加圆角
    /// - Parameters:
    ///   - corners: The corners of a rectangle
    ///   - radius: 圆角半径
    func roundCorners(_ corners: UIRectCorner, _ radius: CGFloat) {
        let path = UIBezierPath.init(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize.init(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        layer.mask = shape
    }
}

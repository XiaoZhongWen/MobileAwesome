//
//  UIView+Corner.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/5/24.
//

import UIKit

extension UIView {
    func withCorner(_ radius: CGFloat, _ corners: UIRectCorner = .allCorners) {
        let maskPath = UIBezierPath.init(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize.init(width: radius, height: radius))
        maskPath.lineWidth = 0.0
        let maskLayer = CAShapeLayer.init()
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
}

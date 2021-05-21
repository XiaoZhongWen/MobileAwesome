//
//  CornerButton.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/5/21.
//

import UIKit

class CornerButton: UIButton {
    private let cornerRadius: CGFloat;
    init(cornerRadius: CGFloat) {
        self.cornerRadius = cornerRadius
        super.init(frame: CGRect.zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let maskPath = UIBezierPath.init(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: CGSize.init(width: cornerRadius, height: cornerRadius))
        maskPath.lineWidth = 0.0
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = rect
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}

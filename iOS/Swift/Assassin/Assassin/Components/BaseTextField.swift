//
//  BaseTextField.swift
//  Assassin
//
//  Created by 肖仲文 on 2021/5/19.
//

import UIKit

class BaseTextField: UITextField {
    init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = BackgroundColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let maskPath = UIBezierPath.init(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: CornerRadii)
        maskPath.lineWidth = 0.0
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = rect
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}

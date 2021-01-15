//
//  UIColor+Ex.swift
//  Assassin-Native
//
//  Created by 肖仲文 on 2021/1/11.
//  Copyright © 2021 肖仲文. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hexString: String) {
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)

        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }

        var color: UInt32 = 0
        scanner.scanHexInt32(&color)

        let mask = 0x000000FF
        let rMask = Int(color >> 16) & mask
        let gMask = Int(color >> 8) & mask
        let bMask = Int(color) & mask

        let red   = CGFloat(rMask) / 255.0
        let green = CGFloat(gMask) / 255.0
        let blue  = CGFloat(bMask) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}

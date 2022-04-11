//
//  UIImage+Ex.swift
//  mcs_photo_picker
//
//  Created by 肖仲文 on 2022/3/30.
//

import Foundation
import CoreGraphics

extension UIImage {
    func reRenderImage(width: Int, height: Int) -> UIImage? {
        let size = CGSize.init(width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        draw(in: CGRect.init(x: 0, y: 0, width: width, height: height))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }

    func fixOrientation() -> UIImage? {
        if self.imageOrientation == .up {
            return self
        }

        var transform = CGAffineTransform.identity
        switch self.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x:self.size.width, y:self.size.height)
            transform = transform.rotated(by: .pi)
            break

        case .left, .leftMirrored:
            transform = transform.translatedBy(x:self.size.width, y:0)
            transform = transform.rotated(by: .pi/2)
            break

        case .right, .rightMirrored:
            transform = transform.translatedBy(x:0, y:self.size.height)
            transform = transform.rotated(by: -.pi/2)
            break

        default:
            break
        }

        switch self.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x:self.size.width, y:0)
            transform = transform.scaledBy(x:-1, y:1)
            break

        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x:self.size.height, y:0);
            transform = transform.scaledBy(x:-1, y:1)
            break
        default:
            break
        }

        let ctx = CGContext(data:nil, width:Int(self.size.width), height:Int(self.size.height), bitsPerComponent:self.cgImage!.bitsPerComponent, bytesPerRow:0, space:self.cgImage!.colorSpace!, bitmapInfo:self.cgImage!.bitmapInfo.rawValue)
        ctx?.concatenate(transform)

        switch self.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx?.draw(self.cgImage!, in:CGRect(x:CGFloat(0), y:CGFloat(0), width:CGFloat(size.height), height:CGFloat(size.width)))
            break

        default:
            ctx?.draw(self.cgImage!, in:CGRect(x:CGFloat(0), y:CGFloat(0), width:CGFloat(size.width), height:CGFloat(size.height)))
            break
        }

        let cgImg:CGImage = (ctx?.makeImage())!
        let img = UIImage(cgImage: cgImg)
        return img
    }
}

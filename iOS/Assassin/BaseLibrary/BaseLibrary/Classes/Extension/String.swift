//
//  String.swift
//  BaseLibrary
//
//  Created by 肖仲文 on 2020/12/21.
//

import Foundation
import CommonCrypto

extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
    
    var md5 : String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
         
        CC_MD5(str!, strLen, result)
     
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize(count: digestLen)
         
        return String(format: hash as String)
    }
}

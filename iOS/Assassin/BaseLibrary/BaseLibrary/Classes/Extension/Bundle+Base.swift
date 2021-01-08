//
//  Bundle+Base.swift
//  BaseLibrary
//
//  Created by 肖仲文 on 2021/1/8.
//

import Foundation

extension Bundle {
    static func baseLibraryBundle() -> Bundle? {
        let bundle = Bundle.init(for: DaoService.self)
        let url = bundle.url(forResource: "BaseLibrary", withExtension: "bundle")
        if let bundleUrl = url {
            return Bundle.init(url: bundleUrl)
        } else {
            return nil
        }
    }
}

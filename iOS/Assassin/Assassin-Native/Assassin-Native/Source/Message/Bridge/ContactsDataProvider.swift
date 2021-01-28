//
//  ContactsDataProvider.swift
//  Assassin-Native
//
//  Created by 肖仲文 on 2021/1/27.
//  Copyright © 2021 肖仲文. All rights reserved.
//

import Foundation
import BaseLibrary
import Moya

@objc(ContactsDataProvider)
class ContactsDataProvider: NSObject {
    @objc(fetchContactsList:rejecter:)
    func fetchContactsList(resolver: @escaping RCTPromiseResolveBlock, rejecter: @escaping RCTPromiseRejectBlock) {
        Apis.shared.fetchContactsList { result in
            switch result {
            case let .success(response):
                if response.statusCode == 200 {
                    let json = try? response.mapString()
                    resolver(json)
                }
            case let .failure(error):
                rejecter(error.response?.statusCode.description, error.errorDescription, error)
            }
        }
    }
}

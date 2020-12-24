//
//  AppConfigTests.swift
//  Assassin-NativeTests
//
//  Created by 肖仲文 on 2020/12/24.
//  Copyright © 2020 肖仲文. All rights reserved.
//

import Quick
import Nimble
import OHHTTPStubs

@testable import BaseLibrary

class AppConfigTests: QuickSpec {

    override func spec() {
        describe("AppConfig Unit Tests") {
            describe("fetch app config") {
                it("should NOT fetch app config with invalid domain or bundleId or productId") {
                    
                }
                
                it("should fetch app config with valid domain and bundleId and productId") {
                    
                }
            }
        }
    }

}

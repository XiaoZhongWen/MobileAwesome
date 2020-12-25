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
                beforeEach() {
                    stub(condition: isAbsoluteURLString("https://dev.chinamye.com//cache/plat/getTabsByGuid/")) {
                        _ in
                        return HTTPStubsResponse(data:Data(), statusCode:200, headers: ["Content-Type":"application/json"])
                    }
                }
                it("should NOT fetch app config with invalid domain or bundleId or productId") {
                    AppConfig.shared.fetchConfig(domain: "", bundleId: "", productId: "") { (result) in
                        switch result {
                        case .success(_):
                            expect(true) == false
                        case .failure(_):
                            expect(true) == true
                        }
                    }
                }
                
                it("should fetch app config with valid domain and bundleId and productId") {
                    
                }
            }
        }
    }

}

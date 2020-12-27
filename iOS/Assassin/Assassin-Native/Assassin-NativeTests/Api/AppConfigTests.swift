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
import Moya

@testable import BaseLibrary

class AppConfigTests: QuickSpec {
    let timeout = 10.0
    override func spec() {
        describe("AppConfig Unit Tests") {
            describe("fetch app config") {
                let productID = "8e12d6b3bde4463391a267c7ac44c428"
                beforeEach() {
                    stub(condition: isAbsoluteURLString("https://dev.chinamye.com/cache/plat/getTabsByGuid/\(productID)")) {
                        _ in
                        let stubPath = OHPathForFile("app_config.json", type(of: self))
                        return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
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
                    waitUntil(timeout: self.timeout) { (done) in
                        AppConfig.shared.fetchConfig(domain: "cike.com", bundleId: "com.mye.assassin", productId: productID) { (result) in
                            switch result {
                            case let .success(response):
                                do {
                                    let dict = try response.mapJSON() as? NSDictionary
                                    let version = dict?["version"] as? NSNumber
                                    expect(version) == 100
                                } catch {}
                                done()
                            case .failure(_):
                                expect(true) == false
                                done()
                            }
                        }
                    }
                }
            }
            
            describe("fetch oauth token") {
                beforeEach {
                    stub(condition: isAbsoluteURLString("https://openapi.chinamye.com/mauth/oauth2/login")) {
                        _ in
                        let stubPath = OHPathForFile("token.json", type(of: self))
                        return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
                    }
                }
                
                it("should fetch oauth token") {
                    waitUntil(timeout: self.timeout) { (done) in
                        OpenApi.shared.fetchToken { (result) in
                            switch result {
                            case let .success(response):
                                do {
                                    let dict = try response.mapJSON() as? NSDictionary
                                    let token = dict?["access_token"] as? String
                                    expect(token) == "cfdfe553-5893-4ccf-bc10-a8f533be5351-1"
                                    done()
                                } catch {}
                            case .failure(_):
                                expect(true) == false
                                done()
                            }
                        }
                    }
                }
            }
        }
    }
}

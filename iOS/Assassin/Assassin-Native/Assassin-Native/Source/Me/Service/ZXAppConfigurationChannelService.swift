//
//  ZXAppConfigurationChannelService.swift
//  Assassin-Native
//
//  Created by 肖仲文 on 2021/1/11.
//  Copyright © 2021 肖仲文. All rights reserved.
//

// swiftlint:disable force_cast

import Foundation
import Flutter
import BaseLibrary

class ZXAppConfigurationChannelService {
    var channel: FlutterMethodChannel

    init(with flutterViewController: FlutterViewController) {
        channel = FlutterMethodChannel.init(
            name: Global_Application_Configuration_Channel,
            binaryMessenger: flutterViewController as! FlutterBinaryMessenger)
        channel.setMethodCallHandler { call, result in
            if call.method == Global_Application_Configuration_Channel_FetchThemeColor {
                self.fetchThemeColor(with: result)
            } else if call.method == Global_Application_Configuration_Channel_FetchAccount {
                self.fetchAccount(with: result)
            } else if call.method == Global_Application_Configuration_Channel_FetchTabs {
                self.fetchTabs(with: result)
            }
        }
    }
}

extension ZXAppConfigurationChannelService {
// MARK: - channel methods

    /// 获取主题颜色
    /// - Parameter result: <#result description#>
    func fetchThemeColor(with result: (Any) -> Void) {
        result(Global_Theme_Color)
    }

    /// 获取账号信息
    /// - Parameter result: <#result description#>
    func fetchAccount(with result: (Any) -> Void) {
        let userService = UserService()
        if let account = userService.activeAccount() {
            if let json = account.toJSONString() {
                result(json)
            } else {
                result(Global_Flutter_Error("parser account failure!"))
            }
        } else {
            result(Global_Flutter_Error("account is nil!"))
        }
    }

    /// 获取tab配置
    /// - Parameter result: <#result description#>
    func fetchTabs(with result: (Any) -> Void) {
        let params = ApplicationConfigurationService.shared.fetchMineParams()
        result(params as Any)
    }
}

//
//  Constant.swift
//  Assassin-Native
//
//  Created by 肖仲文 on 2020/12/30.
//  Copyright © 2020 肖仲文. All rights reserved.
//

// swiftlint:disable identifier_name

import UIKit
import Flutter

let Global_Theme_Color = "#31b66c"
let Global_BackgroundColor = UIColor.init(white: 242.0 / 255.0, alpha: 1.0)
let Global_Domain = "cike.com"
let Global_BundleId = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String ?? ""
let Global_ProductId = "8e12d6b3bde4463391a267c7ac44c428"
let Global_ApplicationConfiguration_Key = "ApplicationConfiguration"

let Global_Conversation_Page_Size = 20;

let Global_Flutter_Me_Page_RouteName = "flutter_me_page"
let Global_Flutter_Share_Page_RouteName = "flutter_share_page"
let Global_Application_Configuration_Channel = "application_configuration"
let Global_Application_Configuration_Channel_FetchThemeColor = "fetchThemeColor"
let Global_Application_Configuration_Channel_FetchAccount = "fetchAccount"
let Global_Application_Configuration_Channel_FetchTabs = "fetchTabs"

let Global_Flutter_Error = { message in
    return FlutterError.init(code: "UNAVAILABLE", message: message, details: nil)
}

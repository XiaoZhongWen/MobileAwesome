//
//  ApplyPermission.swift
//  mcs_photo_picker
//
//  Created by 肖仲文 on 2022/4/7.
//

import Foundation
import AVFoundation

enum ApplyType {
    case camera
    case audio
    case addressBook
    case photoLibrary
    case location
    case calendar
}

class ApplyPermission {
    static func requestCompetence(type: ApplyType, callback: @escaping (_ enable: Bool) -> Void) {
        var mediaType:AVMediaType?
        switch type {
        case .camera:
            mediaType = .video
        case .audio:
            // todo
            mediaType
        case .addressBook:
            // todo
            mediaType
        case .photoLibrary:
            // todo
            mediaType
        case .location:
            // todo
            mediaType
        case .calendar:
            // todo
            mediaType
        }

        if mediaType == nil {
            callback(false)
        }

        let status = AVCaptureDevice.authorizationStatus(for: mediaType!)
        if (status == .denied) {
            callback(false)
        } else if (status == .authorized) {
            callback(true)
        } else if (status == .notDetermined) {
            AVCaptureDevice.requestAccess(for: mediaType!) { grant in
                DispatchQueue.main.async {
                    callback(grant)
                }
            }
        }
    }

    static func openSystemSetting(type: ApplyType) {
        var title:String?
        var content:String?
        let appName = Bundle.main.infoDictionary?["CFBundleDisplayName"]
        switch type {
        case .camera:
            title = "无法使用麦克风"
            content = "请在iPhone的\"设置-隐私-麦克风\"中允许\(appName!)访问您的麦克风"
        case .audio:
            title = "无法使用相机"
            content = "请在iPhone的\"设置-隐私-相机\"中允许\(appName!)访问您的相机"
        case .addressBook:
            title = "无法访问通讯录"
            content = "请在iPhone的\"设置-隐私-通讯录\"中允许\(appName!)访问您的通讯录"
        case .photoLibrary:
            title = "无法访问相册"
            content = "请在iPhone的\"设置-隐私-相册\"中允许\(appName!)访问您的相册"
        case .location:
            title = "请开启精确位置"
            content = "请到【设置-%@APP-位置】中打开\(appName!)【精确位置】开关，以便我们为您提供更加准确的位置服务"
        case .calendar:
            title = "请开启日历"
            content = "请到【设置-%@APP-位置】中打开\(appName!)【日历】开关，以便我们为您提供添加日程服务"
        }
        DispatchQueue.main.async {
            let alertVc = UIAlertController.init(title: title, message: content, preferredStyle: .alert)
            alertVc.addAction(UIAlertAction.init(title: "设置", style: .default, handler: { action in
                let url = URL.init(string: UIApplication.openSettingsURLString)
                if UIApplication.shared.canOpenURL(url!) {
                    UIApplication.shared.openURL(url!)
                }
            }))
        }
    }

}

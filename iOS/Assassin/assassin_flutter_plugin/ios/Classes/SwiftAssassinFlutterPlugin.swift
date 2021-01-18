import Flutter
import UIKit

public class SwiftAssassinFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "assassin_flutter_plugin", binaryMessenger: registrar.messenger())
    let instance = SwiftAssassinFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "doRequest":
        if let arguments = call.arguments as? NSDictionary {
            if let actionName = arguments["actionName"] as? NSString {
                if actionName.isEqual(to: "updatePortrait") {
                    result(["url" : "https://tvax2.sinaimg.cn/crop.0.0.512.512.180/b4505429ly8gcwoi6xlvcj20e80e8glx.jpg?KID=imgbed,tva&Expires=1610529427&ssig=tLCaUL06i8"])
                } else if actionName.isEqual(to: "fetchShares") {
                    let path = "/Volumes/Julien/Mine/MobileAwesome/iOS/Assassin/share.txt"
                    let str = try? String.init(contentsOfFile: path) ?? ""
                    result(str)
                }
            }
        }
    default:
        result("mismatch")
    }
    result("iOS " + UIDevice.current.systemVersion)
  }
}

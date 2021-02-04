import Flutter
import UIKit
import BaseLibrary

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
                    var pageSize: Int?
                    if let params = arguments["params"] {
                        let dict = params as? NSDictionary
                        if let size = dict?.object(forKey: "pageSize") {
                            pageSize = size as? Int
                        }
                    }
                    fetchShareList(pageSize: pageSize ?? 10, flutterResult: result)
                } else if actionName.isEqual(to: "fetchMoreShares") {
                    var pageSize: Int?
                    var sessionId: String?
                    if let params = arguments["params"] {
                        let dict = params as? NSDictionary
                        if let size = dict?.object(forKey: "pageSize") {
                            pageSize = size as? Int
                        }
                        if let id = dict?.object(forKey: "sessionId") {
                            sessionId = id as? String
                        }
                    }
                    fetchMoreShares(pageSize: pageSize ?? 10, sessionId: sessionId ?? "", flutterResult: result)
                }
            }
        }
    default:
        result("mismatch")
    }
  }

    public func fetchShareList(pageSize: Int, flutterResult: @escaping FlutterResult) {
        Share.shared.fetchLatest(pageSize: pageSize) { result in
            switch result {
            case let .success(response):
                do {
                    let str = try response.mapString()
                    flutterResult(str)
                } catch {
                    flutterResult("")
                }
                break
            case .failure(_):
                flutterResult("")
                break
            }
        }
    }

    public func fetchMoreShares(pageSize: Int, sessionId: String, flutterResult: @escaping FlutterResult) {
        Share.shared.fetchMore(pageSize: pageSize, sessionId: sessionId) { result in
            switch result {
            case let .success(response):
                do {
                    let str = try response.mapString()
                    flutterResult(str)
                } catch {
                    flutterResult("")
                }
                break
            case .failure(_):
                flutterResult("")
                break
            }
        }
    }
}

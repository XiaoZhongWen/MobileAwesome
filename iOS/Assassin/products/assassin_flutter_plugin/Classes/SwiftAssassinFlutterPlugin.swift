import Flutter
import UIKit

public class SwiftAssassinFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "assassin_flutter_plugin", binaryMessenger: registrar.messenger())
    let instance = SwiftAssassinFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    
  }
}

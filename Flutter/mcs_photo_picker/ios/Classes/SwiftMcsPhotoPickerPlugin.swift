import Flutter
import UIKit
import HXPhotoPicker

public class SwiftMcsPhotoPickerPlugin: NSObject, FlutterPlugin, HXCustomNavigationControllerDelegate {

    var result_: FlutterResult?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "mcs_photo_picker", binaryMessenger: registrar.messenger())
    let instance = SwiftMcsPhotoPickerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      result_ = result
      switch call.method {
      case "pickMultiImage":
          if let arguments = call.arguments as? NSDictionary {
              var selectedType = 0
              var canEdit = false
              var showBytes = false;
              if let type = arguments["type"] as? Int {
                  selectedType = type
              }
              if let showOriginalBytes = arguments["showOriginalBytes"] as? Bool {
                  showBytes = showOriginalBytes
              }
              if let videoCanEdit = arguments["videoCanEdit"] as? Bool {
                  canEdit = videoCanEdit
              }
              pickMultiImage(type: selectedType, videoCanEdit: canEdit, showOriginalBytes: showBytes)
          }
          break;
      case "reRenderImage":
          if let arguments = call.arguments as? NSDictionary {
              if let path = arguments["path"] as? String,
                 let width = arguments["width"] as? Int,
                 let height = arguments["height"] as? Int {
                  reRenderImage(path: path, width: width, height: height)
              }
          }
      default:
          result("iOS " + UIDevice.current.systemVersion)
          break;
      }
  }

    public func pickMultiImage(
        type:Int,
        videoCanEdit:Bool,
        showOriginalBytes:Bool) {
        var selectedType = HXPhotoManagerSelectedType.photo
        switch type {
        case 0:
            selectedType = HXPhotoManagerSelectedType.photo
        case 1:
            selectedType = HXPhotoManagerSelectedType.video
        case 2:
            selectedType = HXPhotoManagerSelectedType.photoAndVideo
        default:
            break
        }
        let photoManager = HXPhotoManager.init(type: selectedType)
        photoManager?.configuration.type = .wxChat
        photoManager?.configuration.videoCanEdit = videoCanEdit
        photoManager?.configuration.showOriginalBytes = showOriginalBytes
        photoManager?.configuration.openCamera = false
        photoManager?.configuration.statusBarStyle = .default
        if let manager = photoManager {
            if let nav = HXCustomNavigationController.init(manager: manager, delegate: self) {
                let rootVc = UIApplication.shared.keyWindow?.rootViewController;
                rootVc?.present(nav, animated: true, completion: nil)
            }
        }
    }

    public func reRenderImage(path:String, width: Int, height: Int) {
        let image = UIImage.init(contentsOfFile: path)
        if let img = image?.reRenderImage(width: width, height: height) {
            let dPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let imageDir = "/thumbnail"
            let base = dPath + imageDir
            if let fileName = path.split(separator: "/").last {
                let filePath = base + "/" + String.init(fileName)
                let url = URL.init(fileURLWithPath: filePath)
                do {
                    try HX_UIImageJPEGRepresentation(img)?.write(to: url)
                    self.result_?(filePath)
                } catch {}
            }
        }
    }

    func handleAsset(imageAssets:[PHAsset], videoAssets:[PHAsset], imageList:[Data], _ original: Bool) {
        var map:[String:Any] = [
            "original":original
        ]
        var images = Array.init(imageList)

        let group = DispatchGroup.init()

        let imageGroup = DispatchGroup.init()
        if (imageAssets.count > 0) {
            group.enter()
            let option = PHImageRequestOptions.init()
            option.isNetworkAccessAllowed = true
            option.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
            imageAssets.forEach { asset in
                imageGroup.enter()
                PHImageManager.default().requestImageData(for: asset, options: option) { imageData, dataUTI, orientation, info in
                    if let data = imageData {
                        images.append(data)
                    }
                    imageGroup.leave()
                }
            }
        }

        imageGroup.notify(queue: DispatchQueue.global()) {
            if (images.count > 0) {
                let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                let imageDir = "/image"
                let base = path + imageDir
                if (!FileManager.default.fileExists(atPath: base)) {
                    do {
                        try FileManager.default.createDirectory(atPath: base, withIntermediateDirectories: false, attributes: nil)
                    } catch {}
                }
                var imagePaths:[String] = []
                do {
                    try images.forEach { data in
                        if let uuid = String.uuid() {
                            let imgPath = base + "/" + uuid
                            let url = URL.init(fileURLWithPath: imgPath)
                            try data.write(to: url)
                            imagePaths.append(imgPath)
                        }
                    }
                } catch {}

                var images:[[String:Any]] = []
                for file in imagePaths {
                    let url = NSURL.init(fileURLWithPath: file)
                    if let source = CGImageSourceCreateWithURL(url, nil),
                       let imageProperties = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) as? Dictionary<String, Any> {
                        if let width = imageProperties["PixelWidth"],
                           let height = imageProperties["PixelHeight"] {
                            images.append(
                                [
                                    "path":file,
                                    "width": width,
                                    "height":height
                                ]
                            )
                        }
                    }
                }
                map["images"] = images
            }
            group.leave()
        }

        let videoGroup = DispatchGroup.init()
        if (videoAssets.count > 0) {
            group.enter()
            let options = PHVideoRequestOptions.init()
            options.deliveryMode = PHVideoRequestOptionsDeliveryMode.fastFormat
            options.version = PHVideoRequestOptionsVersion.original
            options.isNetworkAccessAllowed = true
            var videoPaths:[String] = []
            videoAssets.forEach { asset in
                videoGroup.enter()
                PHImageManager.default().requestAVAsset(forVideo: asset, options: options) { asset, audioMix, info in
                    if let urlAsset = asset as? AVURLAsset {
                        videoPaths.append(urlAsset.url.path)
                    }
                    videoGroup.leave()
                }
            }
            videoGroup.notify(queue: DispatchQueue.global()) {
                var videos:[[String:Any]] = []
                for video in videoPaths {
                    videos.append(["path":video])
                }
                map["videos"] = videos
                group.leave()
            }
        }

        group.notify(queue: DispatchQueue.global()) {
            if (self.result_ != nil) {
                self.result_?(map)
            }
        }
    }

    // Mark:- HXCustomNavigationControllerDelegate
    public func photoNavigationViewController(_: HXCustomNavigationController, didDoneAllList: [HXPhotoModel], photos: [HXPhotoModel], videos: [HXPhotoModel], original: Bool) {
        var imageAssets:[PHAsset] = []
        var videoAssets:[PHAsset] = []
        var imageList:[Data] = []
        if (photos.count > 0) {
            photos.forEach { m in
                if let img = m.photoEdit?.editPreviewImage {
                    if let data = HX_UIImagePNGRepresentation(img) {
                        imageList.append(data)
                    }
                } else if let asset = m.asset {
                    imageAssets.append(asset)
                }
            }
        }
        if (videos.count > 0) {
            videos.forEach { m in
                if let asset = m.asset {
                    videoAssets.append(asset)
                }
            }
        }
        handleAsset(imageAssets: imageAssets, videoAssets: videoAssets, imageList: imageList, original)
    }
}

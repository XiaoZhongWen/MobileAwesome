#import "McsPhotoPickerPlugin.h"
#if __has_include(<mcs_photo_picker/mcs_photo_picker-Swift.h>)
#import <mcs_photo_picker/mcs_photo_picker-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "mcs_photo_picker-Swift.h"
#endif

@implementation McsPhotoPickerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMcsPhotoPickerPlugin registerWithRegistrar:registrar];
}
@end
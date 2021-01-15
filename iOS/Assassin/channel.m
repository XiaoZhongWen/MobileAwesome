FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:@"application_configuration" binaryMessenger:(FlutterViewController *)self.window.rootViewController];
    [channel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if ([@"fetchThemeColor" isEqualToString:call.method]) {
            result(@"#31b66c");
        } else if ([@"fetchAccount" isEqualToString:call.method]) {
            NSDictionary *dict = @{
                @"username": @"13545118725",
                @"cnname": @"肖仲文",
                @"headUrl": @"https://ceph.chinamye.com/M00/02/85/CgoD-FuPhUeAdKRWAAOFfA_eC34014.png"
            };
            NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingFragmentsAllowed error:nil];
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            result(str);
        } else if ([@"fetchTabs" isEqualToString:call.method]) {
            result(@"{\"isGrid\":true,\"items\":[{\"name\":\"我的空间\",\"aliasName\":\"share\",\"iconUrl\":\"\",\"url\":\"\",\"type\":\"0\"},{\"name\":\"我的工作\",\"aliasName\":\"work\",\"iconUrl\":\"\",\"url\":\"\",\"type\":\"1\"},{\"name\":\"我的云盘\",\"iconUrl\":\"\",\"url\":\"\",\"type\":\"3\"},{\"name\":\"我的群发\",\"aliasName\":\"amass\",\"iconUrl\":\"\",\"url\":\"\",\"type\":\"4\"},{\"name\":\"我的收藏\",\"aliasName\":\"collect\",\"iconUrl\":\"\",\"url\":\"\",\"type\":\"6\"},{\"name\":\"健康打卡\",\"iconUrl\":\"https://ceph.chinamye.com/paas/939063504bfb438d9c9ddf376a027fee/%E6%89%93%E5%8D%A1%281%29.png\",\"url\":\"https://dk.chinamye.com\",\"type\":\"\"},{\"name\":\"CRM管理\",\"iconUrl\":\"https://ceph.chinamye.com/paas/939063504bfb438d9c9ddf376a027fee/CRM%402x%20%282%29.png\",\"url\":\"https://crm.chinamye.com/mobile\",\"type\":\"\"},{\"name\":\"培训\",\"iconUrl\":\"https://ceph.chinamye.com/paas/939063504bfb438d9c9ddf376a027fee/%E5%9F%B9%E8%AE%AD.png\",\"url\":\"https://zxt-m.chinamye.com\",\"type\":\"\"},{\"name\":\"设置\",\"aliasName\":\"setup\",\"iconUrl\":\"\",\"url\":\"\",\"type\":\"7\"}]}");
        }
    }];
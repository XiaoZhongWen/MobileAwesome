import 'dart:io';

import 'package:assassin_flutter_module/channels/application_configuration_channel.dart';
import 'package:assassin_flutter_module/pages/me/models/account.dart';
import 'package:image_picker/image_picker.dart';
import 'package:assassin_flutter_module/widgets/action_sheet.dart';
import 'package:flutter/material.dart';
import 'package:assassin_flutter_module/constants.dart';
import 'package:assassin_flutter_plugin/assassin_flutter_plugin.dart';

class BusinessCard extends StatefulWidget {
  @override
  _BusinessCardState createState() => _BusinessCardState();
}

class _BusinessCardState extends State<BusinessCard> {
  Account _account;
  PickedFile _imageFile;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    ApplicationConfigurationChannel.shared.fetchAccount().then((account) {
      setState(() {
        _account = account;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: business_card_height,
      child: Card(
        margin: EdgeInsets.all(default_margin),
        shadowColor: Colors.black54,
        child: Row(
          children: [
            GestureDetector(
              child: Container(
                height: business_card_icon_size,
                margin: EdgeInsets.only(left: business_card_icon_left_margin, right: business_card_icon_right_margin),
                child: ClipOval(
                  child: _loadPortrait(),
                ),
              ),
              onTap: () => _onPortraitTap(context)
            ),
            Container(
              height: business_card_icon_size,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_account?.nickname ?? "请登录", style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),),
                  Text(_account?.username ?? "", style: TextStyle(
                      fontWeight: FontWeight.w400
                  ),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _loadPortrait() {
    if (_account?.headUrl == null) {
      return Image.asset("images/portrait.png", width: business_card_icon_size, height: business_card_icon_size, fit: BoxFit.fill);
    } else if (_imageFile?.path != null) {
      return Image.file(File(_imageFile.path), width: business_card_icon_size, height: business_card_icon_size, fit: BoxFit.fill,);
    } else {
      return Image.network(_account.headUrl, width: business_card_icon_size, height: business_card_icon_size);
    }
  }

  void _onActionSheetTap(int index) async {
    switch (index) {
      case -1: {
        // 取消
        Navigator.of(context).pop();
        break;
      }
      case 0: {
        // 拍照
        PickedFile pickedFile = await _imagePicker.getImage(source: ImageSource.camera);
        _updatePortrait(pickedFile.path);
        break;
      }
      case 1: {
        // 从相册选择
        PickedFile pickedFile = await _imagePicker.getImage(source: ImageSource.gallery);
        _updatePortrait(pickedFile.path);
        break;
      }
    }
  }

  void _updatePortrait(String path) async {
    try {
      Map response = await AssassinFlutterPlugin.doRequest(action_name_update_portrait, {"path":path});
      String url = response["url"];
      setState(() {
        _account.headUrl = url;
      });
    } catch (error) {
      print(error);
    }
  }

  void _onPortraitTap(BuildContext context) {
    showModalBottomSheet(context: context, builder: (BuildContext context) {
      return ActionSheet(Key(this.runtimeType.toString()), ["拍照", "从相册选择"], _onActionSheetTap);
    },
    backgroundColor: Color.fromARGB(0, 255, 255, 255));
  }
}
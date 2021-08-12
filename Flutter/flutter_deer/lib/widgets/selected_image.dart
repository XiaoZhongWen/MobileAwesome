import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:image_picker/image_picker.dart';

class SelectedImage extends StatefulWidget {
  const SelectedImage({
    Key? key,
    this.url,
    this.size = 80.0
  }): super(key: key);

  final String? url;
  final double size;

  _SelectedImageState createState() => _SelectedImageState();
}

class _SelectedImageState extends State<SelectedImage> {

  final ImagePicker _picker = ImagePicker();
  ImageProvider? _provider;
  PickedFile? _pickedFile;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          image: DecorationImage(
            image: _provider ?? ImageUtils.getImageProvider(widget.url, holderImg: "store/icon_zj"),
            fit: BoxFit.cover
          )
        ),
      ),
      onTap: _getImage,
    );
  }

  Future<void> _getImage() async {
    try {
      _pickedFile = await _picker.getImage(source: ImageSource.gallery);
      if (_pickedFile != null) {
        _provider = FileImage(File(_pickedFile!.path));
      }
      setState(() {

      });
    } catch(e) {
      print(e);
    }
  }
}
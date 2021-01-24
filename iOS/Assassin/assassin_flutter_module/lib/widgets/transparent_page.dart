import 'package:assassin_flutter_module/pages/share/widgets/share_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class TransparentPage extends StatefulWidget {
  @override
  _TransparentPageState createState() => _TransparentPageState();
}

class _TransparentPageState extends State<TransparentPage> {

  FocusNode _focusNode = FocusNode();
  FocusScopeNode _focusScopeNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    KeyboardVisibilityController visibilityController = KeyboardVisibilityController();
    visibilityController.onChange.listen((bool visible) {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          if (index == 5) {
            return FlatButton(
                onPressed: () {
                  showBottomSheet(
                      context: context,
                      builder: (context) {
                        MediaQuery.of(context).size.width;
                        return Container(
                          height: 44.0,
                          color: Colors.blue,
                        );
                      }
                  );
                },
                child: Text("modal")
            );
          } else {
            return ListTile(
                title: Text(index.toString())
            );
          }
        },
      )
    );
  }
}

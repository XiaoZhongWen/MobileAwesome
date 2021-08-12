import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_2d_amap/flutter_2d_amap.dart';
import 'package:flutter_deer/res/Dimens.dart';
import 'package:flutter_deer/res/gaps.dart';
import 'package:flutter_deer/res/styles.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/shop/shop_router.dart';
import 'package:flutter_deer/store/store_router.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/widgets/fd_app_bar.dart';
import 'package:flutter_deer/widgets/fd_button.dart';
import 'package:flutter_deer/widgets/selected_image.dart';
import 'package:flutter_deer/widgets/selected_item.dart';
import 'package:flutter_deer/widgets/textfield_item.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class StoreAuditPage extends StatefulWidget {

  const StoreAuditPage({Key? key}): super(key: key);

  _StoreAuditPageState createState() => _StoreAuditPageState();
}

class _StoreAuditPageState extends State<StoreAuditPage> {

  final FocusNode _storeNameNode = FocusNode();
  final FocusNode _storeOwnerNode = FocusNode();
  final FocusNode _storePhoneNumberNode = FocusNode();
  String _category = "";
  String _address = "";
  
  @override
  Widget build(BuildContext context) {

    Widget content = KeyboardActions(
      config: _buildConfig(context),
      tapOutsideToDismiss: true,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.vGap5,
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text("店铺资料", style: TextStyles.textBold18),
            ),
            Gaps.vGap10,
            Center(
              child: SelectedImage(),
            ),
            Gaps.vGap5,
            Center(
              child: Text("店主手持身份证或营业执照", style: Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: Dimens.font_sp14),),
            ),
            Gaps.vGap16,
            TextFieldItem(
              title: "店铺名称",
              hintText: "填写店铺名称",
            ),
            SelectedItem(
              title: "主营范围",
              content: _category,
              onTap: choiceCategory,
            ),
            SelectedItem(
              title: "店铺地址",
              content: _address,
              onTap: choiceAddress,
            ),
            Gaps.vGap32,
            Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text("店主信息", style: TextStyles.textBold18),
            ),
            Gaps.vGap16,
            TextFieldItem(
              title: "店主姓名",
              hintText: "填写店主姓名",
            ),
            TextFieldItem(
              title: "联系电话",
              hintText: "填写店主联系电话",
            )
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: FDAppBar(
        centerTitle: "店铺审核资料",
      ),
      body: Column(
        children: [
          Expanded(
            child: content,
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: FdButton(
                text: "提交",
                onPressed: () {
                  NavigatorUtils.push(context, StoreRouter.auditResultPage);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void choiceAddress() {
    NavigatorUtils.pushResult(context, ShopRouter.addressSelectPage, (result) {
      setState(() {
        // final PoiSe
        final PoiSearch model = result as PoiSearch;
        _address = model.provinceName ?? "" + ' ' +
            (model.cityName ?? "") + ' ' +
            (model.adName ?? "") + ' ' + (model.title ?? "");
      });
    });
  }

  void choiceCategory() {
    final List<String> datasource = ['水果生鲜', '家用电器', '休闲食品', '茶酒饮料', '美妆个护', '粮油调味', '家庭清洁', '厨具用品', '儿童玩具', '床上用品'];
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.7,
            builder: (_, scrollController) {
              return ListView.builder(
                itemCount: datasource.length,
                itemExtent: 48.0,
                controller: scrollController,
                itemBuilder: (_, index) {
                  return InkWell(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(datasource[index]),
                    ),
                    onTap: () {
                      setState(() {
                        _category = datasource[index];
                      });
                      NavigatorUtils.goBack(context);
                    },
                  );
                },
              );
            },
          );
        }
    );
  }

  Widget buttonBuilder(FocusNode focusNode) {
    return GestureDetector(
      onTap: focusNode.unfocus,
      child: Text("关闭"),
    );
  }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: ThemeUtils.getKeyboardActionsColor(context),
      actions: [
        KeyboardActionsItem(
          focusNode: _storeNameNode,
          displayDoneButton: false
        ),
        KeyboardActionsItem(
          focusNode:_storeOwnerNode,
          displayDoneButton: false
        ),
        KeyboardActionsItem(
          focusNode: _storePhoneNumberNode,
          toolbarButtons: [buttonBuilder]
        )
      ]
    );
  }
}
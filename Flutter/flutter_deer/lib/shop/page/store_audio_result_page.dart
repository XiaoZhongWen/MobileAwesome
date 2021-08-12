import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/gaps.dart';
import 'package:flutter_deer/res/styles.dart';
import 'package:flutter_deer/routers/fluro_navigator.dart';
import 'package:flutter_deer/routers/routers.dart';
import 'package:flutter_deer/widgets/fd_app_bar.dart';
import 'package:flutter_deer/widgets/fd_button.dart';
import 'package:flutter_deer/widgets/load_image.dart';

class StoreAudioStorePage extends StatefulWidget {

  const StoreAudioStorePage({Key? key}): super(key: key);

  _StoreAudioStorePageState createState() => _StoreAudioStorePageState();
}

class _StoreAudioStorePageState extends State<StoreAudioStorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FDAppBar(
        title: "审核结果",
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Gaps.vGap50,
            LoadAssetImage("store/icon_success", width: 80.0, height: 80.0),
            Gaps.vGap12,
            Text("恭喜，店铺资料审核成功", style: TextStyles.textBold16,),
            Gaps.vGap8,
            Text("2021-02-21 15:20:10", style: Theme.of(context).textTheme.subtitle2,),
            Gaps.vGap8,
            Text("预计完成时间：02月28日", style: Theme.of(context).textTheme.subtitle2,),
            Gaps.vGap24,
            FdButton(
              text: "进入",
              onPressed: () {
                NavigatorUtils.push(context, Routers.home, clearStack: true);
              },
            )
          ],
        ),
      ),
    );
  }
}
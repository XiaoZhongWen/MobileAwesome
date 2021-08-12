import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/widgets/SearchBar.dart';
import 'package:flutter_2d_amap/flutter_2d_amap.dart';
import 'package:flutter_deer/widgets/fd_button.dart';

class SelectAddressPage extends StatefulWidget {

  _SelectAddressPageState createState() => _SelectAddressPageState();
}

class _SelectAddressPageState extends State<SelectAddressPage> {

  List<PoiSearch> _list = [];
  int _index = 0;
  final ScrollController _controller = ScrollController();
  AMap2DController? _aMap2DController;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Flutter2dAMap.setApiKey(
      iOSKey: '4327916279bf45a044bb53b947442387',
      webKey: '4e479545913a3a180b3cffc267dad646',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBar(hintText: "搜索地址",),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: AMap2DView(),
            ),
            Expanded(
                flex: 11,
                child: ListView.separated(
                  controller: _controller,
                  separatorBuilder: (_, index) => const Divider(),
                  itemCount: _list.length,
                  itemBuilder: (_, index) {
                    return _AddressItem(
                      isSelected: _index == index,
                      date: _list[index],
                      onTap: () {
                        _index = index;
                        _aMap2DController?.move(_list[index].latitude ?? "", _list[index].longitude ?? "");
                        setState(() {
                        });
                      },
                    );
                  },
                )
            ),
            FdButton(
              text: "确认选择地址",
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}

class _AddressItem extends StatelessWidget {

  const _AddressItem({
    Key? key,
    required this.date,
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);

  final PoiSearch date;
  final bool isSelected;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        height: 50.0,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                (date.provinceName ?? "") + ' ' +
                    (date.cityName ?? "") + ' ' +
                    (date.adName ?? "") + ' ' + (date.title ?? ""),
              ),
            ),
            Visibility(
              visible: isSelected,
              child: const Icon(Icons.done, color: Colors.blue),
            )
          ],
        ),
      ),
    );
  }
}
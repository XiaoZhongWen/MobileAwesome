import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> with SingleTickerProviderStateMixin {

  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  late Animation<double> _animation;
  late AnimationController _animationController;

  bool _isFold = true;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        duration: const Duration(milliseconds: 250),
        vsync: this
    );
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _animation = Tween(begin: 0.0, end: 200.0).animate(_animation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                    child: _buildList()
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        focusNode: _focusNode,
                      ),
                    ),
                    IconButton(onPressed: (){
                      _focusNode.hasFocus? _focusNode.unfocus(): _focusNode.requestFocus();
                    }, icon: Icon(Icons.book)),
                    IconButton(onPressed: (){
                      if (_focusNode.hasFocus) {
                        _focusNode.unfocus();
                      }
                      _isFold = !_isFold;
                      _isFold? _animationController.reverse(): _animationController.forward();
                      _scrollController.animateTo(
                          0.0,
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.ease);
                    }, icon: Icon(Icons.ten_k_rounded))
                  ],
                ),
                AnimatedBuilder(
                  animation: _animation,
                  builder: (_, child) {
                    return Container(
                      height: _animation.value,
                      child: child,
                    );
                  },
                  child: Container(
                    color: Colors.brown,
                  ),
                )
              ],
            )
          ],
        ),
      )
    );
  }

  Widget _buildList() {
    return Align(
      alignment: Alignment.topCenter,
      child: ListView.builder(
        reverse: true,
        shrinkWrap: true,
        controller: _scrollController,
        itemBuilder: (_, index) {
          return SizedBox(
            child: Text(index.toString()),
          );
        },
        itemCount: 100,
      ),
    );
  }
}

// return Scaffold(
// appBar: AppBar(),
// body: SafeArea(
// child: Stack(
// children: [
// Column(
// children: [
// Expanded(
// child: Align(
// alignment: Alignment.topCenter,
// child: ListView.builder(
// reverse: true,
// shrinkWrap: true,
// controller: _scrollController,
// itemBuilder: (_, index) {
// return SizedBox(
// child: Text(index.toString()),
// );
// },
// itemCount: 100,
// ),
// )
// ),
// Row(
// children: [
// Expanded(
// child: _buildInputContainer(),
// // child: TextField(
// //   focusNode: _focusNode,
// // ),
// ),
// IconButton(onPressed: (){
// _focusNode.hasFocus? _focusNode.unfocus(): _focusNode.requestFocus();
// }, icon: Icon(Icons.book)),
// IconButton(onPressed: (){
// if (_focusNode.hasFocus) {
// _focusNode.unfocus();
// }
// _isFold = !_isFold;
// _isFold? _animationController.reverse(): _animationController.forward();
// _scrollController.animateTo(
// 0.0,
// duration: const Duration(milliseconds: 250),
// curve: Curves.ease);
// }, icon: Icon(Icons.ten_k_rounded))
// ],
// ),
// _buildOperationMenu(),
// // AnimatedBuilder(
// //   animation: _animation,
// //   builder: (_, child) {
// //     return Container(
// //       height: _animation.value,
// //       child: child,
// //     );
// //   },
// //   child: Container(
// //     color: Colors.brown,
// //   ),
// // )
// ],
// )
// ],
// ),
// )
// );

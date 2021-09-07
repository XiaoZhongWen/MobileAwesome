import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FdFlexibleSpaceBar extends StatefulWidget {

  const FdFlexibleSpaceBar({
    Key? key,
    this.title,
    this.background,
    this.centerTitle,
    this.titlePadding,
    this.collapseMode = CollapseMode.parallax
  }): super(key: key);

  final Widget? title;
  final Widget? background;
  final bool? centerTitle;
  final CollapseMode collapseMode;
  final EdgeInsetsGeometry? titlePadding;

  static Widget createSettings({
    double? toolbarOpacity,
    double? minExtent,
    double? maxExtent,
    required double currentExtent,
    required Widget child,
  }) {
    return FlexibleSpaceBarSettings(
        toolbarOpacity: toolbarOpacity ?? 1.0,
        minExtent: minExtent ?? currentExtent,
        maxExtent: maxExtent ?? currentExtent,
        currentExtent: currentExtent,
        child: child
    );
  }

  _FdFlexibleSpaceBarState createState() => _FdFlexibleSpaceBarState();
}

class _FdFlexibleSpaceBarState extends State<FdFlexibleSpaceBar> {

  final GlobalKey _key = GlobalKey();

  double? _getCollapsePadding(double t, FlexibleSpaceBarSettings settings) {
    switch (widget.collapseMode) {
      case CollapseMode.pin:
        return -(settings.maxExtent - settings.currentExtent);
      case CollapseMode.none:
        return 0.0;
      case CollapseMode.parallax:
        final double deltaExtent = settings.maxExtent - settings.minExtent;
        return -Tween<double>(begin: 0.0, end: deltaExtent / 4.0).transform(t);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final FlexibleSpaceBarSettings settings = context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>()!;
    final List<Widget> children = <Widget>[];
    final double deltaExtent = settings.maxExtent - settings.minExtent;

    final double t = (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent).clamp(0.0, 1.0);

    if (widget.background != null) {
      children.add(
          Positioned(
              top: _getCollapsePadding(t, settings),
              left: 0.0,
              right: 0.0,
              height: settings.maxExtent,
              child: widget.background!
          )
      );
    }

    if (widget.title != null) {
      final ThemeData theme = Theme.of(context);
      Widget title = Container(
        key: _key,
        child: widget.title,
      );

      final double opacity = settings.toolbarOpacity;
      if (opacity > 0.0) {
        TextStyle titleStyle = theme.primaryTextTheme.headline6!;
        titleStyle = titleStyle.copyWith(
            color: titleStyle.color!.withOpacity(opacity),
            fontWeight: t !=0? FontWeight.normal: FontWeight.bold
        );
        final EdgeInsetsGeometry padding = widget.titlePadding ?? EdgeInsetsDirectional.only(
            start: 0.0,
            bottom: 16.0
        );
        final double scaleValue = Tween(begin: 1.5, end: 1.0).transform(t);
        final double width = (size.width - 32.0) / 2;
        final Matrix4 scaleTransform = Matrix4.identity()..scale(scaleValue, scaleValue, 1.0)..translate(t * width, 0.0);
        final Alignment titleAlignment = Alignment.bottomLeft;
        children.add(
            Container(
              padding: padding,
              child: Transform(
                alignment: titleAlignment,
                transform: scaleTransform,
                child: Align(
                  alignment: titleAlignment,
                  child: DefaultTextStyle(
                    style: titleStyle,
                    child: title,
                  ),
                ),
              ),
            )
        );
      }
    }

    return ClipRRect(child: Stack(children: children));
  }
}
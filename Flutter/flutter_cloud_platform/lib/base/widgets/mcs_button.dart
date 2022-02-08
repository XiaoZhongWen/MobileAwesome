import 'package:flutter/material.dart';

class MCSButton extends MaterialButton {
  MCSButton({
    Key? key,
    VoidCallback? onPressed,
    ValueChanged<bool>? onHighlightChanged,
    ButtonTextTheme? textTheme,
    Color? textColor,
    Color? disabledTextColor,
    Color? color,
    Color? disabledColor,
    Color? focusColor,
    Color? hoverColor,
    Color? highlightColor,
    Color? splashColor,
    Brightness? colorBrightness,
    double? elevation,
    double? hoverElevation,
    double? focusElevation,
    double? highlightElevation,
    double? disabledElevation,
    EdgeInsetsGeometry? padding,
    VisualDensity? visualDensity,
    ShapeBorder? shape,
    Clip clipBehavior = Clip.none,
    FocusNode? focusNode,
    bool autofocus = false,
    MaterialTapTargetSize? materialTapTargetSize,
    Duration? animationDuration,
    double? minWidth,
    double? height,
    bool enableFeedback = true,
    EdgeInsetsGeometry textPadding = EdgeInsets.zero,
    Widget? label,
    this.leftIcon,
    this.topIcon,
    this.rightIcon,
    this.bottomIcon,
  }) :  assert(clipBehavior != null),
        assert(autofocus != null),
        assert(elevation == null || elevation >= 0.0),
        assert(focusElevation == null || focusElevation >= 0.0),
        assert(hoverElevation == null || hoverElevation >= 0.0),
        assert(highlightElevation == null || highlightElevation >= 0.0),
        assert(disabledElevation == null || disabledElevation >= 0.0),
        super(
          key: key,
          onPressed:onPressed,
          onHighlightChanged: onHighlightChanged,
          textTheme: textTheme,
          textColor: textColor,
          disabledTextColor: disabledTextColor,
          color: color,
          disabledColor: disabledColor,
          focusColor: focusColor,
          hoverColor: hoverColor,
          highlightColor: highlightColor,
          splashColor: splashColor,
          colorBrightness: colorBrightness,
          elevation: elevation,
          hoverElevation: hoverElevation,
          focusElevation: focusElevation,
          highlightElevation: highlightElevation,
          disabledElevation: disabledElevation,
          padding: padding,
          visualDensity: visualDensity,
          shape: shape,
          clipBehavior: clipBehavior,
          focusNode: focusNode,
          autofocus: autofocus,
          materialTapTargetSize: materialTapTargetSize,
          animationDuration: animationDuration,
          minWidth: minWidth,
          height: height,
          enableFeedback: enableFeedback,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Offstage(
                offstage: topIcon == null,
                child: topIcon,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Offstage(
                    offstage: leftIcon == null,
                    child: leftIcon,
                  ),
                  Padding(
                    padding: textPadding,
                    child: label,
                  ),
                  Offstage(
                    offstage: rightIcon == null,
                    child: rightIcon,
                  )
                ],
              ),
              Offstage(
                offstage: bottomIcon == null,
                child: bottomIcon,
              )
            ],
          )
      );

  final Widget? leftIcon;
  final Widget? topIcon;
  final Widget? rightIcon;
  final Widget? bottomIcon;
}
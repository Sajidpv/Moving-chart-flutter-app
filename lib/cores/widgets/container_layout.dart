import 'package:flutter/material.dart';

Material buildContainer(
  Widget child, {
  bool isCentered = false,
  bool isBorder = false,
  double padding = 0.0,
  double margin = 0.0,
  double? width,
  double? height,
  BorderRadiusGeometry? borderRadius,
  Color color = Colors.transparent,
  double elevation = 5.0,
  double radius = 8.0,
}) {
  return Material(
    elevation: elevation,
    // shadowColor: Colors.red,
    borderRadius: BorderRadius.circular(radius),
    child: Container(
      margin: EdgeInsets.all(margin),
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: isBorder ? Border.all(color: Colors.grey) : null,
        borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(radius)),
        color: color,
      ),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: isCentered
            ? Center(
                child: child,
              )
            : child,
      ),
    ),
  );
}

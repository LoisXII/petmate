import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:petmate/main.dart';

class MyButtonTemplate extends StatelessWidget {
  double width;
  double height;
  double? elevation;
  AlignmentGeometry? alignment;
  Color? shadowColor;
  double? radius;
  void Function()? onPressed;
  String text;
  TextStyle? style;
  Color? backgroundColor;
  Color? foregroundColor;
  IconData? icon;
  Color? icon_color;
  BorderRadiusGeometry? borderRadius;
  double? top;

  MyButtonTemplate({
    super.key,
    this.alignment,
    this.icon,
    this.elevation,
    required this.height,
    required this.onPressed,
    this.radius,
    this.borderRadius,
    this.shadowColor,
    this.icon_color,
    required this.text,
    this.backgroundColor,
    this.foregroundColor,
    this.style,
    this.top,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.transparent,
      margin: EdgeInsets.only(top: top ?? 0),
      child: LayoutBuilder(
        builder: (context, constraints) => LayoutBuilder(
          builder: (context, constraints) => Row(
            children: [
              // icon .
              icon != null
                  ? Container(
                      width: constraints.maxWidth * .20,
                      height: constraints.maxHeight,
                      decoration: BoxDecoration(
                          color: backgroundColor ?? Colors.white,
                          borderRadius: BorderRadius.circular(radius ?? 0)),
                      child: Icon(
                        icon ?? Icons.abc,
                        size: constraints.maxHeight * .75,
                        color: icon_color ?? Colors.white,
                      ),
                    )
                  : const SizedBox(),

              //
              icon != null
                  ? SizedBox(
                      width: constraints.maxWidth * 0.025,
                      height: constraints.maxHeight * 0.025,
                    )
                  : const SizedBox(),

              // buttom
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    alignment: alignment,
                    elevation: elevation,
                    shadowColor: shadowColor,
                    fixedSize: Size(
                        icon != null
                            ? constraints.maxWidth * 0.77
                            : constraints.maxWidth,
                        constraints.maxHeight),
                    backgroundColor: backgroundColor ?? color2,
                    foregroundColor: foregroundColor ?? color1,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          borderRadius ?? BorderRadius.circular(radius ?? 0),
                    )),
                onPressed: onPressed,
                child: AutoSizeText(
                  text,
                  style: style ?? Theme.of(context).textTheme.headlineLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

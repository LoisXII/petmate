import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  Color? backgroundcolor;
  Color? backgroundcolor_loading;
  double? width;
  double? height;

  LoadingIndicator({
    super.key,
    this.backgroundcolor,
    this.height,
    this.width,
    this.backgroundcolor_loading,
  });

  @override
  Widget build(BuildContext context) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Container(
      width: mainw,
      height: mainh,
      color: backgroundcolor ?? Colors.transparent,
      alignment: Alignment.center,
      child: LayoutBuilder(
        builder: (context, constraints) => UnconstrainedBox(
          child: Container(
            width: constraints.maxWidth * .30,
            height: constraints.maxHeight * .12,
            decoration: BoxDecoration(
              color: backgroundcolor_loading ?? Colors.grey[50],
              borderRadius: BorderRadius.circular(5),
            ),
            alignment: Alignment.center,
            child: LayoutBuilder(
              builder: (context, constraints) => CupertinoActivityIndicator(
                animating: true,
                radius: constraints.maxHeight * 0.25,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

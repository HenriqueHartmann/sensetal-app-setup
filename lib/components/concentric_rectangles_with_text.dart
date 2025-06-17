import 'package:flutter/material.dart';
import 'package:sensetal_presentation_design_app/theme/app_border_radius.dart';

class ConcentricRectangles extends StatelessWidget {
  final String text;
  final Color outerColor;
  final Color middleColor;
  final Color innerColor;
  final TextStyle? textStyle;
  final double padding;
  final double height;
  final double width;

  const ConcentricRectangles({
    super.key,
    required this.text,
    this.outerColor = const Color.fromARGB(255, 0, 140, 255),
    this.middleColor = const Color.fromARGB(255, 61, 190, 251),
    this.innerColor = const Color.fromARGB(255, 122, 203, 240),
    this.textStyle,
    this.padding = 4,
    this.height = 22,
    this.width = 29,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: outerColor,
        borderRadius: AppBorderRadius.md,
      ),
      padding: EdgeInsets.all(padding),
      child: Container(
        decoration: BoxDecoration(
          color: middleColor,
          borderRadius: AppBorderRadius.md,
        ),
        padding: EdgeInsets.all(padding),
        child: Container(
          decoration: BoxDecoration(
            color: innerColor,
            borderRadius: AppBorderRadius.md,
          ),
          child: Center(
            child: Text(
              text,
              style: textStyle ?? Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

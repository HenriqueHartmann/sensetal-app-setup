import 'package:flutter/material.dart';
import 'package:sensetal_presentation_design_app/theme/app_border_radius.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';

Map<String, Color> cronicaColorTheme = {
  'outer': AppColors.info05,
  'middle': AppColors.info04,
  'inner': AppColors.info03,
};

Map<String, Color> agudaColorTheme = {
  'outer': AppColors.error05,
  'middle': AppColors.error04,
  'inner': AppColors.error03,
};

class ConcentricRectangles extends StatelessWidget {
  final String text;
  final String painType; // 'aguda', 'cronica'
  //final Color? outerColor; // se painType for 'custom'
  //final Color? middleColor; // se painType for 'custom'
  //final Color? innerColor; // se painType for 'custom'
  final TextStyle? textStyle;
  final double padding;
  final double height;
  final double width;

  const ConcentricRectangles({
    super.key,
    required this.text,
    required this.painType,
    // this.outerColor,
    // this.middleColor,
    // this.innerColor,
    this.textStyle,
    this.padding = 4,
    this.height = 22,
    this.width = 29,
  });

  @override
  Widget build(BuildContext context) {
    Color outer;
    Color middle;
    Color inner;

    if (painType == 'aguda') {
      outer = agudaColorTheme['outer']!;
      middle = agudaColorTheme['middle']!;
      inner = agudaColorTheme['inner']!;
    } else {
      // 'cronica'
      outer = cronicaColorTheme['outer']!;
      middle = cronicaColorTheme['middle']!;
      inner = cronicaColorTheme['inner']!;
    }

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: outer,
        borderRadius: AppBorderRadius.md,
      ),
      padding: EdgeInsets.all(padding),
      child: Container(
        decoration: BoxDecoration(
          color: middle,
          borderRadius: AppBorderRadius.md,
        ),
        padding: EdgeInsets.all(padding),
        child: Container(
          decoration: BoxDecoration(
            color: inner,
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

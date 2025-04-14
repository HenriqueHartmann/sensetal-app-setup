
import 'package:flutter/material.dart';
import 'package:sensetal_presentation_design_app/theme/space_size.dart';

/// Vertical spacing widget
class VerticalSpace extends StatelessWidget {
  final SpaceSize size;
  final double? custom;

  const VerticalSpace({
    Key? key,
    required this.size,
    this.custom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: getSizeFromEnum(size, custom));
  }
}

/// Horizontal spacing widget
class HorizontalSpace extends StatelessWidget {
  final SpaceSize size;
  final double? custom;

  const HorizontalSpace({
    Key? key,
    required this.size,
    this.custom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: getSizeFromEnum(size, custom));
  }
}

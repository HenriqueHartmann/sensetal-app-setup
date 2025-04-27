import 'package:flutter/material.dart';
import 'package:sensetal_presentation_design_app/components/label_widget.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/space_widgets.dart';

class CustomLabeledInput extends StatelessWidget {
  final String label;
  final Widget child;

  const CustomLabeledInput({Key? key, required this.label, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelWidget(label: label),
        const VerticalSpace(size: AppSpaceSize.xs),
        child
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/space_widgets.dart';

class LabeledInput extends StatelessWidget {
  final String label;
  final String placeholder;
  final TextEditingController? controller;

  const LabeledInput({
    super.key,
    required this.label,
    required this.placeholder,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.neutral03,
              ),
        ),
        const VerticalSpace(size: AppSpaceSize.xs),
        Container(
          padding:
              EdgeInsets.all(getSizeFromEnum(AppSpaceSize.md)), // Frame padding
          decoration: BoxDecoration(
            color: AppColors.neutralWhite, // background
            border: Border.all(
              color: AppColors.primary04, // border
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8), // radius
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: const TextStyle(color: AppColors.neutral04),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}

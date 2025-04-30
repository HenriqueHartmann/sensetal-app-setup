import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';
import 'package:sensetal_presentation_design_app/theme/app_icons.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/space_widgets.dart';

class PasswordRequirement {
  final String label;
  final bool isValid;

  PasswordRequirement({required this.label, required this.isValid});
}

class PasswordRequirementList extends StatelessWidget {
  final String? title;
  final List<PasswordRequirement> requirements;
  final String? warningMessage;

  const PasswordRequirementList({
    super.key,
    this.title,
    required this.requirements,
    this.warningMessage,
  });

  @override
  Widget build(BuildContext context) {
    const double iconValidationWidth = 18.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: AppColors.neutral01),
          ),
          const VerticalSpace(size: AppSpaceSize.md),
        ],
        for (final entry in requirements.asMap().entries) ...[
          Row(
            children: [
              SvgPicture.asset(
                entry.value.isValid
                    ? AppIcons.systemSensetalIconCheckMark
                    : AppIcons.systemSensetalIconXCircle,
                width: iconValidationWidth,
                color: entry.value.isValid
                    ? AppColors.success02
                    : AppColors.error02,
                semanticsLabel: entry.value.isValid ? 'Check icon' : 'X icon',
              ),
              const HorizontalSpace(size: AppSpaceSize.xxs),
              Text(
                entry.value.label,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: AppColors.neutral03),
              ),
            ],
          ),
          if (entry.key != requirements.length - 1)
            const VerticalSpace(size: AppSpaceSize.xs),
        ],
        if (warningMessage != null) ...[
          const VerticalSpace(size: AppSpaceSize.md),
          Text(
            warningMessage!,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: AppColors.neutral01),
          ),
        ],
      ],
    );
  }
}

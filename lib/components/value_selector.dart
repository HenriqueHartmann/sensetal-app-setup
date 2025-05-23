import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';
import 'package:sensetal_presentation_design_app/theme/app_icons.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/space_widgets.dart';

class ValueSelector extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const ValueSelector({
    super.key,
    required this.label,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: AppColors.neutral03),
        ),
        const VerticalSpace(size: AppSpaceSize.xs),
        Row(
          children: [
            _CircleIconButton(
              icon: AppIcons.systemSensetalIconMinus,
              onPressed: onDecrement,
            ),
            const HorizontalSpace(size: AppSpaceSize.sm),
            Expanded(
              child: Container(
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.neutral05),
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.neutralWhite),
                child: Text(
                  value,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.neutral01,
                      ),
                ),
              ),
            ),
            const HorizontalSpace(size: AppSpaceSize.sm),
            _CircleIconButton(
              icon: AppIcons.systemSensetalIconPlus,
              onPressed: onIncrement,
            ),
          ],
        ),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final String icon;
  final VoidCallback onPressed;

  const _CircleIconButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getSizeFromEnum(AppSpaceSize.xl),
      height: getSizeFromEnum(AppSpaceSize.xl),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.neutral05,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.neutral05,
            width: 1,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onPressed,
            child: Padding(
              padding: EdgeInsets.all(getSizeFromEnum(AppSpaceSize.xs)),
              child: SvgPicture.asset(
                icon,
                color: AppColors.primary02,
                semanticsLabel: 'Sensetal system icon',
              ),
            ),
          ),
        ),
      ),
    );
  }
}

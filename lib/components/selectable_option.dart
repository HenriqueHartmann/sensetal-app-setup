import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';
import 'package:sensetal_presentation_design_app/theme/app_icons.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';

enum SelectionType { radio, checkbox }

class SelectableOption<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T> onChanged;
  final String label;
    final bool isSelected;
  final SelectionType type;

  const SelectableOption({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.label,
    required this.isSelected,
    this.type = SelectionType.radio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icon = type == SelectionType.radio
        ? (isSelected
            ? AppIcons.systemSensetalIconRadioOn
            : AppIcons.systemSensetalIconRadioOff)
        : (isSelected
            ? AppIcons.systemSensetalIconCheckMark
            : AppIcons.systemSensetalIconPlus); // Exemplo para checkbox

    final backgroundColor =
        isSelected ? AppColors.neutral05 : AppColors.neutralWhite;

    final border = isSelected
        ? null
        : Border.all(color: AppColors.primary04);

    return InkWell(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: border,
        ),
        padding: EdgeInsets.all(getSizeFromEnum(AppSpaceSize.md)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.neutral01),
            ),
            SvgPicture.asset(
              icon,
              width: getSizeFromEnum(AppSpaceSize.custom, 20.0),
              color: AppColors.primary02,
              semanticsLabel: 'Selection icon',
            ),
          ],
        ),
      ),
    );
  }
}

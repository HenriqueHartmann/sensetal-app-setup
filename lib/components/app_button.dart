import 'package:flutter/material.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';

enum AppButtonOptions { solid, outline }

class AppButton extends StatelessWidget {
  final String buttonText;
  final AppButtonOptions buttonType;

ButtonStyle _getButtonStyle(BuildContext _) {
  final isSolid = buttonType == AppButtonOptions.solid;

  final backgroundColor = isSolid
      ? AppColors.secondary02
      : AppColors.neutralWhite;

  final shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(50),
    side: isSolid
        ? BorderSide.none
        : const BorderSide(
            color: AppColors.primary03,
            width: 1,
          ),
  );

  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all(backgroundColor),
    padding: MaterialStateProperty.all(
      EdgeInsets.symmetric(
        horizontal: getSizeFromEnum(AppSpaceSize.md),
        vertical: getSizeFromEnum(AppSpaceSize.xs),
      ),
    ),
    shape: MaterialStateProperty.all(shape),
    elevation: MaterialStateProperty.all(4),
    shadowColor: MaterialStateProperty.all(AppColors.warning01),
  );
}

  const AppButton(
      {Key? key, required this.buttonText, required this.buttonType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: _getButtonStyle(context),
      child: Text(buttonText,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600)),
    );
  }
}

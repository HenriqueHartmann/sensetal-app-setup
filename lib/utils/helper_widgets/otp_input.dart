import 'package:flutter/material.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';

class OtpInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function(String)? onChanged;

  const OtpInputField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const double inputHeight = 64.0;

    return SizedBox(
      width: 48,
      height: inputHeight,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.neutral01),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: inputHeight - 48),
          filled: true,
          fillColor: AppColors.neutralWhite,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppColors.primary04,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppColors.primary04,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: AppColors.primary04,
              width: 1,
            ),
          ),
        ),
        keyboardType: TextInputType.number,
        maxLength: 1,
        buildCounter: (context, {required currentLength, required isFocused, required maxLength}) => null,
      ),
    );
  }
}

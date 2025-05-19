import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sensetal_presentation_design_app/components/label_widget.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';
import 'package:sensetal_presentation_design_app/theme/app_icons.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/space_widgets.dart';

class LabeledInput extends StatefulWidget {
  final String label;
  final String placeholder;
  final TextEditingController? controller;
  final bool showSuffixIcon;

  const LabeledInput({
    super.key,
    required this.label,
    required this.placeholder,
    this.controller,
    this.showSuffixIcon = false,
  });

  @override
  State<LabeledInput> createState() => _LabeledInputState();
}

class _LabeledInputState extends State<LabeledInput> {
  late bool isObscure;

  @override
  void initState() {
    super.initState();

    isObscure = widget.showSuffixIcon;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelWidget(label: widget.label),
        const VerticalSpace(size: AppSpaceSize.xs),
        Container(
          padding:
              EdgeInsets.all(getSizeFromEnum(AppSpaceSize.md)),
          decoration: BoxDecoration(
            color: AppColors.neutralWhite,
            border: Border.all(
              color: AppColors.primary04,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: widget.controller,
            obscureText: isObscure,
            obscuringCharacter: '*',
            decoration: InputDecoration(
              hintText: widget.placeholder,
              hintStyle: const TextStyle(color: AppColors.neutral04),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
              suffixIconConstraints:
                  const BoxConstraints(minHeight: 24, minWidth: 24),
              suffixIcon: widget.showSuffixIcon
                  ? SizedBox(
                      height: 24,
                      width: 24 + getSizeFromEnum(AppSpaceSize.sm),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: getSizeFromEnum(AppSpaceSize.sm),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          child: SvgPicture.asset(
                            isObscure
                                ? AppIcons.systemSensetalIconEyeClosed
                                : AppIcons.systemSensetalIconEyeOpen,
                            semanticsLabel: 'Sensetal icon for action',
                            // ignore: deprecated_member_use
                            color: AppColors.neutral03,
                          ),
                        ),
                      ),
                    )
                  : null,
            ),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}

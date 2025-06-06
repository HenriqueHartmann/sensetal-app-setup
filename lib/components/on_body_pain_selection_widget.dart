import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sensetal_presentation_design_app/theme/app_icons.dart';
import 'package:sensetal_presentation_design_app/theme/app_images.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/space_widgets.dart';

class OnBodyPainSelectionWidget extends StatefulWidget {
  final String gender;
  const OnBodyPainSelectionWidget({super.key, required this.gender});

  @override
  State<OnBodyPainSelectionWidget> createState() =>
      _OnBodyPainSelectionWidgetState();
}

class _OnBodyPainSelectionWidgetState extends State<OnBodyPainSelectionWidget> {
  bool isFrontSide = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  height: 400,
                  child: SvgPicture.asset(
                    (widget.gender == 'Masculino')
                        ? AppImages.maleModelFront
                        : AppImages.femaleModelFront,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: SizedBox(
                  height: 40,
                  width: 80,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppIcons.systemSensetalIconClockwiseArrows,
                        width: 40,
                      ),
                      const HorizontalSpace(size: AppSpaceSize.xs),
                      const Text('Virar')
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

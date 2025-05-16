import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sensetal_presentation_design_app/theme/app_icons.dart';

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
                        ? 'assets/images/male_model_front.svg'
                        : 'assets/images/female_model_front.svg',
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 40,
                  width: 80,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppIcons.systemSensetalIconClockwiseArrows,
                        width: 40,
                      ),
                      SizedBox(width: 8),
                      Text('Virar')
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

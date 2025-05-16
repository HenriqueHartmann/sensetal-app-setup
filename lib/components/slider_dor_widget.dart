import 'package:flutter/material.dart';
import 'package:sensetal_presentation_design_app/components/botao_deslizante_borda.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';

class IMCSlider extends StatefulWidget {
  const IMCSlider({super.key});

  @override
  State<IMCSlider> createState() => _IMCSliderState();
}

class _IMCSliderState extends State<IMCSlider> {
  double _sliderValue = 5;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 8.3,
        activeTrackColor: AppColors.success02,
        inactiveTrackColor: AppColors.neutral05,
        thumbShape: BorderedThumbShape(
          thumbRadius: 12,
          fillColor: AppColors.success01,
          borderColor: AppColors.neutral05, // ou o que quiser
          borderWidth: 2,
          textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.neutral05,
              ),
        ),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
        tickMarkShape: SliderTickMarkShape.noTickMark,
        thumbColor: AppColors.success01,
        valueIndicatorColor: AppColors.success01,
        valueIndicatorTextStyle: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: AppColors.neutral05),
        showValueIndicator: ShowValueIndicator.always,
      ),
      child: Slider(
        value: _sliderValue,
        min: 0,
        max: 10,
        divisions: 10,
        label: _sliderValue.round().toString(),
        onChanged: (value) {
          setState(() {
            _sliderValue = value;
          });
        },
      ),
    );
  }
}

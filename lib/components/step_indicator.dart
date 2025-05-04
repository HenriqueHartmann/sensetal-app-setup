import 'package:flutter/material.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/space_widgets.dart';

class StepIndicatorItem extends StatelessWidget {
  final String label;
  final double progress; // Value between 0.0 and 1.0
  final bool isComplete;

  const StepIndicatorItem({
    super.key,
    required this.label,
    required this.progress,
    required this.isComplete,
  });

  @override
  Widget build(BuildContext context) {
    const double barHeight = 8;

    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: AppColors.primary03),
        ),
        const VerticalSpace(size: AppSpaceSize.xxs),
        SizedBox(
          width: 72,
          height: barHeight,
          child: Stack(
            children: [
              Container(
                width: 72,
                height: barHeight,
                decoration: BoxDecoration(
                  color: isComplete ? AppColors.primary04 : AppColors.primary05,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              if (!isComplete)
                FractionallySizedBox(
                  widthFactor: progress,
                  child: Container(
                    height: barHeight,
                    decoration: BoxDecoration(
                      color: AppColors.secondary02,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }
}

class StepIndicatorData {
  final String label;
  final double progress;

  const StepIndicatorData({
    required this.label,
    required this.progress,
  });

  bool get isComplete => progress >= 1.0;
}

class StepIndicatorRow extends StatelessWidget {
  final List<StepIndicatorData> steps;

  const StepIndicatorRow({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: steps
          .map(
            (step) => Row(
              children: [
                StepIndicatorItem(
                  label: step.label,
                  progress: step.progress,
                  isComplete: step.isComplete,
                ),
                if (step != steps.last)
                  const HorizontalSpace(size: AppSpaceSize.xs),
              ],
            ),
          )
          .toList(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sensetal_presentation_design_app/theme/app_border_radius.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';
import 'package:sensetal_presentation_design_app/theme/app_images.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/space_widgets.dart';

class ImcIndicatorWidget extends StatelessWidget {
  final double imcValue;
  final String imcCategory;
  final String subTextImcCategory;
  final String gender;

  const ImcIndicatorWidget(
      {super.key,
      required this.imcValue,
      required this.imcCategory,
      required this.subTextImcCategory,
      required this.gender});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.primary05,
          borderRadius: AppBorderRadius.lg,
        ),
        padding: EdgeInsets.all(getSizeFromEnum(AppSpaceSize.lg)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 209,
                child: SvgPicture.asset(getFrontBodyImagePath(gender)),
              ),
            ),
            const HorizontalSpace(size: AppSpaceSize.md),
            Expanded(
              flex: 2,
              child: SizedBox(
                width: double.infinity,
                height: 210,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Seu IMC',
                      textAlign: TextAlign.left,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: AppColors.neutral03),
                    ),
                    Text(
                      '(Índice de Massa Corporal)',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: AppColors.neutral03),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: getSizeFromEnum(AppSpaceSize.md)),
                      child: const Divider(
                        color: AppColors.primary04,
                        thickness: 1,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          bottom: getSizeFromEnum(AppSpaceSize.md)),
                      decoration: const BoxDecoration(
                        color: AppColors.primary04,
                        borderRadius: AppBorderRadius.md,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: getSizeFromEnum(AppSpaceSize.xs),
                        horizontal: getSizeFromEnum(AppSpaceSize.md),
                      ),
                      child: Text(
                        imcValue.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(color: AppColors.primary02),
                      ),
                    ),
                    Text(
                      imcCategory,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: AppColors.neutral01),
                    ),
                    Text(
                      subTextImcCategory,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.neutral03),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String getFrontBodyImagePath(String gender) {
  return gender == 'Masculino'
      ? AppImages.maleModelFront
      : AppImages.femaleModelFront;
}

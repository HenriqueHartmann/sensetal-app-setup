import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sensetal_presentation_design_app/theme/app_border_radius.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';

const String valorImc = "20.37";
const String classificacaoImc = "Normal";
const String subTxtClassificacaoImc = "Entre 18.5 e 24.9";

class ImcIndicador extends StatelessWidget {
  const ImcIndicador({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.primary05,
          borderRadius: AppBorderRadius.lg,
        ),
        padding: const EdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: SvgPicture.asset('assets/images/corpo.svg'),
            ),
            const SizedBox(width: 16),
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
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(
                        color: AppColors.primary04,
                        thickness: 1,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: const BoxDecoration(
                        color: AppColors.primary04,
                        borderRadius: AppBorderRadius.md,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      child: Text(
                        valorImc,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(color: AppColors.primary02),
                      ),
                    ),
                    Text(
                      classificacaoImc,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: AppColors.neutral01),
                    ),
                    Text(
                      subTxtClassificacaoImc,
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

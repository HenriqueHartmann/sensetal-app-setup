// Widget utilitário que combina um ícone e texto
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sensetal_presentation_design_app/theme/app_border_radius.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/space_widgets.dart';

class IconTextWidget extends StatelessWidget {
  final String iconPath; // Caminho para o arquivo SVG do ícone
  final String? iconPosition; // Posição do ícone ('left' ou 'top')
  final String
      textOnUpPosition; // Texto a ser exibido ao lado do ícone quando iconPosition for top
  final String text; // Texto a ser exibido abaixo do icone
  final bool hasDivider; // Se deve incluir um divisor

  const IconTextWidget(
      {super.key,
      required this.iconPath,
      this.textOnUpPosition = '',
      this.text = '',
      this.iconPosition,
      this.hasDivider = false});

  @override
  Widget build(BuildContext context) {
    // Função que gera o ícone
    icon() {
      return Container(
        width: 32,
        height: 32,
        padding: EdgeInsets.all(getSizeFromEnum(AppSpaceSize.xxs)),
        decoration: const BoxDecoration(
          color: AppColors.primary04,
          borderRadius: AppBorderRadius.sm,
        ),
        child: SvgPicture.asset(
          iconPath,
        ),
      );
    }

    // Retorna um container com ícone e texto na orientação desejada
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primary05,
        borderRadius: AppBorderRadius.md,
      ),
      padding: EdgeInsets.all(getSizeFromEnum(AppSpaceSize.md)),
      child: iconPosition == 'left'
          // Layout horizontal (ícone à esquerda do texto)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icon(),
                const HorizontalSpace(size: AppSpaceSize.md),
                text.isNotEmpty
                    ? Expanded(
                        child: Text(
                          text,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.neutral01,
                                  ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            )
          // Layout vertical (ícone acima do texto)
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textOnUpPosition.isNotEmpty
                    ? Row(
                        children: [
                          icon(),
                          const HorizontalSpace(size: AppSpaceSize.xs),
                          Text(textOnUpPosition,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: AppColors.neutral01,
                                  )),
                        ],
                      )
                    : Center(child: icon()),
                const VerticalSpace(size: AppSpaceSize.md),
                textOnUpPosition.isNotEmpty
                    ? Text(
                        text,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.neutral01,
                            ),
                      )
                    : Center(
                        child: Text(
                          text,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: AppColors.neutral01,
                                  ),
                        ),
                      )
              ],
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sensetal_presentation_design_app/theme/app_border_radius.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';
import 'package:sensetal_presentation_design_app/theme/app_icons.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/blurred_background.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/space_widgets.dart';

List<String> regioes = [
  "Todas as regiões",
  "Joelho",
  "Lombar",
];

class PageAcompanhamentoDor extends StatefulWidget {
  const PageAcompanhamentoDor({super.key});

  @override
  State<PageAcompanhamentoDor> createState() => _PageAcompanhamentoDorState();
}

class _PageAcompanhamentoDorState extends State<PageAcompanhamentoDor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlurredBackground(
          child: Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  double screenWidth = constraints.maxWidth;
                  double screenHeight = constraints.maxHeight;

                  double logoWidth = screenWidth / 3;
                  double verticalGap = screenHeight > 800
                      ? 150.0
                      : screenHeight > 600
                          ? screenHeight * 0.2
                          : screenHeight * 0.14;
                  double horizontalPadding = screenWidth < 500
                      ? getSizeFromEnum(AppSpaceSize.md)
                      : screenWidth < 800
                          ? getSizeFromEnum(AppSpaceSize.xl)
                          : getSizeFromEnum(AppSpaceSize.custom, 64.0);

                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: getSizeFromEnum(AppSpaceSize.custom, 64.0),
                      ),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            AppIcons.brandSensetalLogo,
                            width: logoWidth,
                            semanticsLabel: 'Sensetal logo',
                          ),
                          VerticalSpace(size: AppSpaceSize.lg),
                          Text("Acompanhamento de dores",
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                      color: AppColors.neutral01,
                                      fontWeight: FontWeight.w700)),
                          VerticalSpace(size: AppSpaceSize.lg),
                          const SelecaoRegiao(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelecaoRegiao extends StatefulWidget {
  const SelecaoRegiao({super.key});

  @override
  State<SelecaoRegiao> createState() => _SelecaoRegiaoState();
}

class _SelecaoRegiaoState extends State<SelecaoRegiao> {
  String _botaoSelecionado = "Todas as regiões";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          regioes.length,
          (index) {
            final isLast = index == regioes.length - 1;
            final isSelected = regioes[index] == _botaoSelecionado;
            return Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _botaoSelecionado = regioes[index];
                    });
                  },
                  child: isSelected
                      ? Container(
                          decoration: const BoxDecoration(
                            color: AppColors.primary02,
                            borderRadius: AppBorderRadius.sm,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: getSizeFromEnum(AppSpaceSize.md),
                            vertical: getSizeFromEnum(AppSpaceSize.xs),
                          ),
                          height: 40,
                          child: Text(regioes[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: AppColors.secondary02)),
                        )
                      : Container(
                          decoration: const BoxDecoration(
                            color: AppColors.primary04,
                            borderRadius: AppBorderRadius.sm,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: getSizeFromEnum(AppSpaceSize.md),
                            vertical: getSizeFromEnum(AppSpaceSize.xs),
                          ),
                          height: 40,
                          child: Text(regioes[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: AppColors.primary02)),
                        ),
                ),
                isLast
                    ? const SizedBox()
                    : SizedBox(
                        width: getSizeFromEnum(AppSpaceSize.xs),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}

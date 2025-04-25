import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sensetal_presentation_design_app/components/app_button.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';
import 'package:sensetal_presentation_design_app/theme/app_icons.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/blurred_background.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/space_widgets.dart';

class PageIndex extends StatefulWidget {
  const PageIndex({super.key});

  @override
  State<PageIndex> createState() => _PageIndexState();
}

class _PageIndexState extends State<PageIndex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlurredBackground(
          showSensetalIcon: true,
          child: Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  double screenWidth = constraints.maxWidth;
                  double screenHeight = constraints.maxHeight;

                  double logoWidth = screenWidth * 0.43;
                  double verticalGap = screenHeight > 800
                      ? 142.0
                      : screenHeight > 600
                          ? screenHeight * 0.2
                          : screenHeight * 0.08;
                  double horizontalPadding = screenWidth < 400
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
                          Column(
                            children: [
                              SvgPicture.asset(
                                AppIcons.sensetalLogo,
                                width: logoWidth,
                                semanticsLabel: 'Sensetal logo',
                              )
                            ],
                          ),
                          VerticalSpace(
                              size: AppSpaceSize.custom, custom: verticalGap),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Atividade física e\nauto-cuidado dirigido',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(
                                      color: AppColors.neutral01,
                                    ),
                              ),
                              const VerticalSpace(size: AppSpaceSize.xs),
                              Text(
                                'Alivie tensões e dores, melhore a sua postura\ne sinta maior disposição ao longo do dia',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: AppColors.neutral03,
                                    ),
                              ),
                            ],
                          ),
                          VerticalSpace(
                              size: AppSpaceSize.custom, custom: verticalGap),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              AppButton(
                                  buttonText: 'Login',
                                  buttonType: AppButtonOptions.solid),
                              VerticalSpace(size: AppSpaceSize.md),
                              AppButton(
                                  buttonText: 'Criar minha conta',
                                  buttonType: AppButtonOptions.outline)
                            ],
                          ),
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

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sensetal_presentation_design_app/theme/app_icons.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/blurred_background.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/space_widgets.dart';

class SensetalScaffold extends StatelessWidget {
  final Widget child;
  final bool showLogo;
  final bool showSensetalIcon;
  final double? customVerticalGap;

  const SensetalScaffold({
    super.key,
    required this.child,
    this.showLogo = true,
    this.showSensetalIcon = true,
    this.customVerticalGap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlurredBackground(
          showSensetalIcon: showSensetalIcon,
          child: LayoutBuilder(
            builder: (context, constraints) {
              double screenWidth = constraints.maxWidth;
              double screenHeight = constraints.maxHeight;

              double logoWidth = screenWidth * 0.43;
              double verticalGap = customVerticalGap ??
                  (screenHeight > 800
                      ? 130.0
                      : screenHeight > 600
                          ? screenHeight * 0.17
                          : screenHeight * 0.12);

              double horizontalPadding = screenWidth < 400
                  ? getSizeFromEnum(AppSpaceSize.md)
                  : screenWidth < 800
                      ? getSizeFromEnum(AppSpaceSize.xl)
                      : getSizeFromEnum(AppSpaceSize.custom, 64.0);

              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: getSizeFromEnum(AppSpaceSize.custom, 64.0),
                    bottom: getSizeFromEnum(AppSpaceSize.xl),
                    left: horizontalPadding,
                    right: horizontalPadding,
                  ),
                  child: Column(
                    children: [
                      if (showLogo)
                        SvgPicture.asset(
                          AppIcons.brandSensetalLogo,
                          width: logoWidth,
                          semanticsLabel: 'Sensetal logo',
                        ),
                      VerticalSpace(
                        size: AppSpaceSize.custom,
                        custom: verticalGap,
                      ),
                      child,
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
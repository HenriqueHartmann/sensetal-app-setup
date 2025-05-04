import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sensetal_presentation_design_app/theme/app_icons.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/blurred_background.dart';

class SensetalScaffold extends StatelessWidget {
  final Widget child;
  final bool showSensetalLogoInTop;
  final bool sensetalLogoIsMini;
  final bool showSensetalIconInBackground;
  final double? customVerticalPadding;

  const SensetalScaffold({
    super.key,
    required this.child,
    this.showSensetalLogoInTop = true,
    this.sensetalLogoIsMini = true,
    this.showSensetalIconInBackground = true,
    this.customVerticalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlurredBackground(
          showSensetalIconInBackground: showSensetalIconInBackground,
          child: LayoutBuilder(
            builder: (context, constraints) {
              double screenWidth = constraints.maxWidth;

              double logoWidth =
                  sensetalLogoIsMini ? screenWidth * 0.27 : screenWidth * 0.43;

              double horizontalPadding = screenWidth < 360
                  ? getSizeFromEnum(AppSpaceSize.md)
                  : screenWidth < 600
                      ? getSizeFromEnum(AppSpaceSize.lg)
                      : getSizeFromEnum(AppSpaceSize.xxl);
              double verticalPadding = customVerticalPadding != null
                  ? customVerticalPadding!
                  : horizontalPadding;

              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: verticalPadding,
                  ),
                  child: Column(
                    children: [
                      if (showSensetalLogoInTop)
                        SvgPicture.asset(
                          AppIcons.brandSensetalLogo,
                          width: logoWidth,
                          semanticsLabel: 'Sensetal logo',
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

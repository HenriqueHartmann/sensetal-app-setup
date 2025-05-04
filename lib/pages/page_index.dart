import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sensetal_presentation_design_app/components/app_button.dart';
import 'package:sensetal_presentation_design_app/components/sensetal_scaffold.dart';
import 'package:sensetal_presentation_design_app/pages/page_login.dart';
import 'package:sensetal_presentation_design_app/pages/page_sign_up_bond.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/space_widgets.dart';

class PageIndex extends StatefulWidget {
  const PageIndex({super.key});

  @override
  State<PageIndex> createState() => _PageIndexState();
}

class _PageIndexState extends State<PageIndex> {

  /// Computes a responsive vertical gap based on the screen height.
///
/// This function returns a vertical spacing value that scales smoothly
/// between two proportional ranges (20% to 25% of screen height), based
/// on the device's height.
///
/// It is useful for spacing elements in a vertically responsive layout,
/// ensuring consistent visual balance across phones, tablets, and foldables.
///
/// - For screens <= 500dp tall, it returns 20% of the height.
/// - For screens >= 1200dp tall, it returns 25% of the height.
/// - For anything in between, it linearly interpolates between the two.
///
/// Example usage:
/// ```dart
/// double verticalGap = computeVerticalGap(MediaQuery.of(context).size.height);
/// SizedBox(height: verticalGap);
/// ```
///
/// [screenHeight] — the current height of the screen in logical pixels (dp).
///
/// Returns a vertical gap in logical pixels (dp).
  double computeVerticalGap(double screenHeight) {
    const minDeviceHeight = 500.0;
    const maxDeviceHeight = 1200.0;

    final minGap = screenHeight * 0.2;
    final maxGap = screenHeight * 0.25;

    if (screenHeight <= minDeviceHeight) return minGap;
    if (screenHeight >= maxDeviceHeight) return maxGap;

    final t = ((screenHeight - minDeviceHeight) /
        (maxDeviceHeight - minDeviceHeight));
    return lerpDouble(minGap, maxGap, t)!;
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final screenHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;

    double verticalGap = computeVerticalGap(screenHeight);

    return SensetalScaffold(
      sensetalLogoIsMini: false,
      customVerticalPadding: getSizeFromEnum(AppSpaceSize.custom, 64.0),
      child: Column(
        children: [
          VerticalSpace(
            size: AppSpaceSize.custom,
            custom: verticalGap,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Atividade física e\nauto-cuidado dirigido',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: AppColors.neutral01),
              ),
              const VerticalSpace(size: AppSpaceSize.xs),
              Text(
                'Alivie tensões e dores, melhore a sua postura\ne sinta maior disposição ao longo do dia',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.neutral03),
              ),
            ],
          ),
          VerticalSpace(size: AppSpaceSize.custom, custom: verticalGap),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AppButton(
                buttonText: 'Login',
                buttonType: AppButtonOptions.solid,
                onPressCallback: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PageLogin(),
                    ),
                  );
                },
              ),
              const VerticalSpace(size: AppSpaceSize.md),
              AppButton(
                buttonText: 'Criar minha conta',
                buttonType: AppButtonOptions.outline,
                onPressCallback: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PageSignUpBond(),
                    ),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

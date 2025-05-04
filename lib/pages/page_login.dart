import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sensetal_presentation_design_app/components/app_button.dart';
import 'package:sensetal_presentation_design_app/pages/page_imc.dart';
import 'package:sensetal_presentation_design_app/pages/page_sign_up_bond.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';
import 'package:sensetal_presentation_design_app/theme/app_icons.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/blurred_background.dart';
import 'package:sensetal_presentation_design_app/components/labeled_input.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/space_widgets.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({Key? key}) : super(key: key);

  @override
  PageLoginState createState() => PageLoginState();
}

class PageLoginState extends State<PageLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlurredBackground(
          showSensetalIconInBackground: true,
          child: Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  double screenWidth = constraints.maxWidth;
                  double screenHeight = constraints.maxHeight;

                  double logoWidth = screenWidth * 0.43;
                  double verticalGap = screenHeight > 800
                      ? 130.0
                      : screenHeight > 600
                          ? screenHeight * 0.17
                          : screenHeight * 0.12;
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
                          SvgPicture.asset(
                            AppIcons.brandSensetalLogo,
                            width: logoWidth,
                            semanticsLabel: 'Sensetal logo',
                          ),
                          VerticalSpace(
                              size: AppSpaceSize.custom, custom: verticalGap),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const LabeledInput(
                                label: 'E-mail corporativo',
                                placeholder: 'E-mail',
                              ),
                              const VerticalSpace(size: AppSpaceSize.lg),
                              const LabeledInput(
                                label: 'Senha',
                                placeholder: 'Senha',
                                showSuffixIcon: true,
                              ),
                              const VerticalSpace(size: AppSpaceSize.lg),
                              Text(
                                'Esqueci minha senha',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: AppColors.primary02,
                                        fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          VerticalSpace(
                              size: AppSpaceSize.custom, custom: verticalGap),
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
                                        builder: (context) => const PageIMC()),
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
                                        builder: (context) =>
                                            const PageSignUpBond()),
                                  );
                                },
                              ),
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

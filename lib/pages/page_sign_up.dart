import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sensetal_presentation_design_app/components/app_button.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';
import 'package:sensetal_presentation_design_app/theme/app_icons.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/blurred_background.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/labeled_input.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/otp_input.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/space_widgets.dart';

class PageSignUp extends StatefulWidget {
  const PageSignUp({super.key});

  @override
  State<PageSignUp> createState() => _PageSignUpState();
}

class _PageSignUpState extends State<PageSignUp> {
  final TextEditingController otpController = TextEditingController();
  final FocusNode otpFocusNode = FocusNode();

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
                      ? 150.0
                      : screenHeight > 600
                          ? screenHeight * 0.2
                          : screenHeight * 0.14;
                  double horizontalPadding = screenWidth < 500
                      ? getSizeFromEnum(AppSpaceSize.md)
                      : screenWidth < 800
                          ? getSizeFromEnum(AppSpaceSize.xl)
                          : getSizeFromEnum(AppSpaceSize.custom, 64.0);

                  double innerVerticalGap = 64.0;

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
                          const VerticalSpace(size: AppSpaceSize.lg),
                          Column(
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
                              size: AppSpaceSize.custom,
                              custom: innerVerticalGap),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const LabeledInput(
                                label: 'E-mail corporativo',
                                placeholder: 'E-mail',
                              ),
                              const VerticalSpace(size: AppSpaceSize.lg),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  OtpInputField(
                                      controller: otpController,
                                      focusNode: otpFocusNode),
                                  const HorizontalSpace(size: AppSpaceSize.md),
                                  OtpInputField(
                                      controller: otpController,
                                      focusNode: otpFocusNode),
                                  const HorizontalSpace(size: AppSpaceSize.md),
                                  OtpInputField(
                                      controller: otpController,
                                      focusNode: otpFocusNode),
                                  const HorizontalSpace(size: AppSpaceSize.md),
                                  OtpInputField(
                                      controller: otpController,
                                      focusNode: otpFocusNode),
                                  const HorizontalSpace(size: AppSpaceSize.md),
                                  OtpInputField(
                                      controller: otpController,
                                      focusNode: otpFocusNode),
                                ],
                              )
                            ],
                          ),
                          VerticalSpace(
                              size: AppSpaceSize.custom,
                              custom: innerVerticalGap),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Precisa de ajuda?',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: AppColors.neutral01,
                                    ),
                              ),
                              const VerticalSpace(size: AppSpaceSize.xs),
                              Text(
                                'Contate-nos',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: AppColors.primary02,
                                        fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const VerticalSpace(
                              size: AppSpaceSize.custom, custom: 64.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              AppButton(
                                buttonText: 'Continuar',
                                buttonType: AppButtonOptions.solid,
                                onPressCallback: () {},
                              ),
                              const VerticalSpace(size: AppSpaceSize.md),
                              AppButton(
                                buttonText: 'Acessar minha conta',
                                buttonType: AppButtonOptions.outline,
                                onPressCallback: () {},
                              )
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

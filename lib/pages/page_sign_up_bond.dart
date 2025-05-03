import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sensetal_presentation_design_app/components/app_button.dart';
import 'package:sensetal_presentation_design_app/components/custom_labeled_input.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';
import 'package:sensetal_presentation_design_app/theme/app_icons.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/blurred_background.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';
import 'package:sensetal_presentation_design_app/components/labeled_input.dart';
import 'package:sensetal_presentation_design_app/components/otp_input.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/space_widgets.dart';
import 'package:sensetal_presentation_design_app/pages/page_sign_up.dart';

class PageSignUpBond extends StatefulWidget {
  const PageSignUpBond({super.key});

  @override
  State<PageSignUpBond> createState() => _PageSignUpBondState();
}

class _PageSignUpBondState extends State<PageSignUpBond> {
  late TextEditingController _corporativeEmailController;
  final int _corporativeCodeLenght = 5;
  late List<TextEditingController> _corporativeCodeControllers;
  late List<FocusNode> _corporativeCodeFocusNode;

  @override
  void initState() {
    _corporativeEmailController = TextEditingController();
    _corporativeCodeControllers = List.generate(
        _corporativeCodeLenght, (index) => TextEditingController());
    _corporativeCodeFocusNode =
        List.generate(_corporativeCodeLenght, (index) => FocusNode());

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _corporativeEmailController.dispose();
    for (var i = 0; i < _corporativeCodeLenght; i++) {
      _corporativeCodeControllers[i].dispose();
      _corporativeCodeFocusNode[i].dispose();
    }
  }

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

                  double logoWidth = screenWidth * 0.43;
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
                          SvgPicture.asset(
                            AppIcons.brandSensetalLogo,
                            width: logoWidth,
                            semanticsLabel: 'Sensetal logo',
                          ),
                          const VerticalSpace(size: AppSpaceSize.lg),
                          Column(
                            children: [
                              Text(
                                'Confirme seu vínculo com a empresa',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(color: AppColors.neutral01),
                              ),
                              const VerticalSpace(size: AppSpaceSize.xs),
                              Text(
                                'Preencha seu e-mail corporativo e o código de acesso para desbloquear a criação da sua conta no Sensetal App',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: AppColors.neutral03,
                                    ),
                              ),
                            ],
                          ),
                          const VerticalSpace(size: AppSpaceSize.xl),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const LabeledInput(
                                label: 'E-mail corporativo',
                                placeholder: 'E-mail',
                              ),
                              const VerticalSpace(size: AppSpaceSize.lg),
                              CustomLabeledInput(
                                label: 'Código da empresa',
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    _corporativeCodeLenght,
                                    (index) => Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        OtpInputField(
                                          controller:
                                              _corporativeCodeControllers[
                                                  index],
                                          focusNode:
                                              _corporativeCodeFocusNode[index],
                                        ),
                                        if (index < 4)
                                          const HorizontalSpace(
                                              size: AppSpaceSize.md),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          VerticalSpace(
                              size: AppSpaceSize.custom,
                              custom: innerVerticalGap),
                          Column(
                            children: [
                              Text(
                                'Precisa de ajuda?',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: AppColors.neutral01),
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
                                buttonText: 'Confirmar vínculo',
                                buttonType: AppButtonOptions.solid,
                                onPressCallback: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PageSignUp()),
                                  );
                                },
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

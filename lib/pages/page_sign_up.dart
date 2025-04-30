import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sensetal_presentation_design_app/components/app_button.dart';
import 'package:sensetal_presentation_design_app/components/password_requirement_list.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';
import 'package:sensetal_presentation_design_app/theme/app_icons.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/blurred_background.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';
import 'package:sensetal_presentation_design_app/components/labeled_input.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/space_widgets.dart';

class PageSignUp extends StatefulWidget {
  const PageSignUp({super.key});

  @override
  State<PageSignUp> createState() => _PageSignUpState();
}

class _PageSignUpState extends State<PageSignUp> {
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
                  double iconValidationWidth = screenWidth * 0.05;

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
                          Column(
                            children: [
                              SvgPicture.asset(
                                AppIcons.brandSensetalLogo,
                                width: logoWidth,
                                semanticsLabel: 'Sensetal logo',
                              )
                            ],
                          ),
                          const VerticalSpace(size: AppSpaceSize.lg),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Crie a sua conta',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(color: AppColors.neutral01),
                              ),
                              const VerticalSpace(size: AppSpaceSize.xs),
                              Text(
                                'Informe seus dados e crie a senha que vai liberar seu acesso ao Sensetal App',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: AppColors.neutral03),
                              ),
                            ],
                          ),
                          const VerticalSpace(size: AppSpaceSize.xl),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const LabeledInput(
                                label: 'Nome completo',
                                placeholder: 'Nome',
                              ),
                              const VerticalSpace(size: AppSpaceSize.lg),
                              const LabeledInput(
                                label: 'Como você gostaria que te chamássemos',
                                placeholder: 'Apelido',
                              ),
                              const VerticalSpace(size: AppSpaceSize.xs),
                              Text(
                                'Digite o nome ou apelido pelo qual você prefere ser chamado(a). Isso nos ajuda a personalizar sua experiência!',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      color: AppColors.neutral01,
                                    ),
                              ),
                              const VerticalSpace(size: AppSpaceSize.lg),
                              // TODO: Add disable feature
                              const LabeledInput(
                                label: 'E-mail corporativo',
                                placeholder: 'E-mail',
                              ),
                              const VerticalSpace(size: AppSpaceSize.lg),
                              const LabeledInput(
                                label: 'Crie uma senha',
                                placeholder: 'Informe uma senha',
                                showSuffixIcon: true,
                              ),
                              const VerticalSpace(size: AppSpaceSize.lg),
                              const LabeledInput(
                                label: 'Confirme a sua senha',
                                placeholder: 'Informe novamente sua senha',
                                showSuffixIcon: true,
                              ),
                            ],
                          ),
                          const VerticalSpace(size: AppSpaceSize.lg),
                          PasswordRequirementList(
                            title: 'A sua senha deve ter:',
                            requirements: [
                              PasswordRequirement(
                                  label: 'Mínimo de 8 caracteres',
                                  isValid: true),
                              PasswordRequirement(
                                  label: '1 carácter maiúsculo', isValid: true),
                              PasswordRequirement(
                                  label: '1 número', isValid: true),
                              PasswordRequirement(
                                  label: '1 carácter especial', isValid: false),
                            ],
                            warningMessage:
                                'Quase lá! Ajuste sua senha para atender a todos os requisitos acima',
                          ),
                          const VerticalSpace(size: AppSpaceSize.lg),
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
                                buttonText: 'Cancelar',
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

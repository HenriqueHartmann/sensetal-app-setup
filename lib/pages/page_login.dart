import 'package:flutter/material.dart';
import 'package:sensetal_presentation_design_app/components/app_button.dart';
import 'package:sensetal_presentation_design_app/components/sensetal_scaffold.dart';
import 'package:sensetal_presentation_design_app/pages/page_imc.dart';
import 'package:sensetal_presentation_design_app/pages/page_sign_up_bond.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';
import 'package:sensetal_presentation_design_app/components/labeled_input.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/space_widgets.dart';
import 'package:sensetal_presentation_design_app/utils/spacing_utils.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({Key? key}) : super(key: key);

  @override
  PageLoginState createState() => PageLoginState();
}

class PageLoginState extends State<PageLogin> {
  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final screenHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;

    double verticalGap = computeVerticalGap(screenHeight, 0.15, 0.2);

    return SensetalScaffold(
      sensetalLogoIsMini: false,
      customVerticalPadding: getSizeFromEnum(AppSpaceSize.custom, 64.0),
      child: Column(
        children: [
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
    );
  }
}

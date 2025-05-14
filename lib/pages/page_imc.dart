import 'package:flutter/material.dart';
import 'package:sensetal_presentation_design_app/components/app_button.dart';
import 'package:sensetal_presentation_design_app/components/sensetal_scaffold.dart';
import 'package:sensetal_presentation_design_app/components/step_indicator.dart';
import 'package:sensetal_presentation_design_app/components/value_selector.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/space_widgets.dart';

class PageIMC extends StatefulWidget {
  const PageIMC({super.key});

  @override
  State<PageIMC> createState() => _PageIMCState();
}

class _PageIMCState extends State<PageIMC> {
  late TextEditingController _weightController;
  late TextEditingController _heightController;

  @override
  void initState() {
    _weightController = TextEditingController();
    _heightController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _weightController.dispose();
    _heightController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SensetalScaffold(
      child: Column(
        children: [
          const VerticalSpace(size: AppSpaceSize.xl),
          const StepIndicatorRow(
            steps: [
              StepIndicatorData(
                label: 'Cadastro',
                progress: 1.0,
              ),
              StepIndicatorData(
                label: 'Anamnese',
                progress: 0.4,
              ),
              StepIndicatorData(
                label: 'Dores',
                progress: 0.0,
              ),
            ],
          ),
          const VerticalSpace(size: AppSpaceSize.xl),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'IMC',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: AppColors.neutral01),
              ),
              const VerticalSpace(size: AppSpaceSize.xs),
              Text(
                'Vamos calcular seu índice de massa corporal',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.neutral03),
              ),
            ],
          ),
          const VerticalSpace(size: AppSpaceSize.xl),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ValueSelector(
                  label: 'Peso',
                  value: '65',
                  onDecrement: () {},
                  onIncrement: () {},
                ),
                const VerticalSpace(size: AppSpaceSize.xl),
                ValueSelector(
                  label: 'Altura',
                  value: '1,70',
                  onDecrement: () {},
                  onIncrement: () {},
                ),
              ],
            ),
          ),
          const VerticalSpace(
            size: AppSpaceSize.custom,
            custom: 190,
          ),
          Column(
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
    );
  }
}

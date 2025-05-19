import 'package:flutter/material.dart';
import 'package:sensetal_presentation_design_app/components/selectable_option_group.dart';
import 'package:sensetal_presentation_design_app/components/sensetal_scaffold.dart';
import 'package:sensetal_presentation_design_app/components/step_indicator.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/space_widgets.dart';

class PageQuestionSelection extends StatefulWidget {
  const PageQuestionSelection({super.key});

  @override
  State<PageQuestionSelection> createState() => _PageQuestionSelectionState();
}

class _PageQuestionSelectionState extends State<PageQuestionSelection> {
  @override
  Widget build(BuildContext context) {
    return SensetalScaffold(
      customVerticalPadding: getSizeFromEnum(AppSpaceSize.xl),
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
                progress: 0.6,
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
                'Anamnese',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: AppColors.neutral01),
              ),
              const VerticalSpace(size: AppSpaceSize.xs),
              Text(
                'Você sente dor muscular ou articular?',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.neutral03),
              ),
            ],
          ),
          const VerticalSpace(size: AppSpaceSize.xl),
          SelectableOptionGroup<String>(
            items: [
              SelectableOptionItem(value: 'sim', label: 'Sim'),
              SelectableOptionItem(value: 'nao', label: 'Não'),
            ],
            mode: SelectionMode.radio,
            selectedValue: 'sim',
            selectedValues: [],
            onRadioChanged: (value) {
              // value é do tipo String
            },
            onCheckboxChanged: (values) {
              // values é List<String>
            },
          ),
          const VerticalSpace(size: AppSpaceSize.custom, custom: 200.0),
/*           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AppButton(
                buttonText: 'Voltar',
                buttonType: AppButtonOptions.outline,
                onPressCallback: () {
                  Navigator.of(context).pop();
                },
              ),
              const VerticalSpace(size: AppSpaceSize.md),
              AppButton(
                buttonText: 'Continuar',
                buttonType: AppButtonOptions.solid,
                onPressCallback: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PageSignUpBond(),
                    ),
                  );
                },
              )
            ],
          ), */
        ],
      ),
    );
  }
}

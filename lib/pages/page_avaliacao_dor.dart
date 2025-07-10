import 'package:flutter/material.dart';
import 'package:sensetal_presentation_design_app/components/app_button.dart';
import 'package:sensetal_presentation_design_app/components/body_pain_selector.dart';
import 'package:sensetal_presentation_design_app/components/on_body_pain_selection_widget.dart';
import 'package:sensetal_presentation_design_app/components/sensetal_scaffold.dart';
import 'package:sensetal_presentation_design_app/components/last_pain_measure_widget.dart';
import 'package:sensetal_presentation_design_app/pages/page_acompanhamento_dor.dart';
import 'package:sensetal_presentation_design_app/pages/page_teste_widget.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/space_widgets.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';

const gender = 'Masculino';

final List<PainMeasureData> uniqueMeasureData = [
  PainMeasureData(
      lastFivePainMeasure: [3, 4, 5, 6, 7],
      lastPainMeasureDate: DateTime.now(),
      painScale: 'aguda'),
  PainMeasureData(
      lastFivePainMeasure: [2, 3, 4, 5, 6],
      lastPainMeasureDate: DateTime.now().subtract(const Duration(days: 1)),
      painScale: 'crônica'),
  PainMeasureData(
      lastFivePainMeasure: [1, 2, 3, 4, 5],
      lastPainMeasureDate: DateTime.now().subtract(const Duration(days: 2)),
      painScale: 'moderada'),
  PainMeasureData(
      lastFivePainMeasure: [0, 1, 2, 3, 4],
      lastPainMeasureDate: DateTime.now().subtract(const Duration(days: 3)),
      painScale: 'leve'),
];

class PageAvaliacaoDor extends StatefulWidget {
  const PageAvaliacaoDor({Key? key}) : super(key: key);

  @override
  PageAvaliacaoDorState createState() => PageAvaliacaoDorState();
}

class PageAvaliacaoDorState extends State<PageAvaliacaoDor> {
  @override
  Widget build(BuildContext context) {
    return SensetalScaffold(
      showBackgroundBlur: false,
      showSensetalIconInBackground: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VerticalSpace(size: AppSpaceSize.lg),
          Text(
            'Vamos acompanhar suas dores!',
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: AppColors.neutral01),
          ),
          const VerticalSpace(size: AppSpaceSize.sm),
          Text(
            'Marque uma ou mais regiões do corpo onde você está sentido dor, e nos conte como está a intensidade de cada uma das dores.',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColors.neutral03),
          ),
          const VerticalSpace(size: AppSpaceSize.sm),
          BodyPainSelector(
            gender: gender,
            painData: uniqueMeasureData,
          ),
          const VerticalSpace(size: AppSpaceSize.sm),
          AppButton(
            buttonText: 'Ver Acompanhamento',
            buttonType: AppButtonOptions.outline,
            onPressCallback: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PageAcompanhamentoDor(),
                ),
              );
            },
          ),
          const VerticalSpace(size: AppSpaceSize.md),
          AppButton(
            buttonText: 'Finalizar',
            buttonType: AppButtonOptions.solid,
            onPressCallback: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PageTeste(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Widget que exibe o conteúdo do bottom sheet para informar intensidade da dor
import 'package:flutter/material.dart';
import 'package:sensetal_presentation_design_app/components/app_button.dart';
import 'package:sensetal_presentation_design_app/components/custom_slider.dart';
import 'package:sensetal_presentation_design_app/components/exclusive_option_list.dart';
import 'package:sensetal_presentation_design_app/components/icon_text_widget.dart';
import 'package:sensetal_presentation_design_app/components/last_pain_measure_widget.dart';
import 'package:sensetal_presentation_design_app/components/on_body_pain_selection_widget.dart';
import 'package:sensetal_presentation_design_app/pages/page_avaliacao_dor.dart';
import 'package:sensetal_presentation_design_app/theme/app_border_radius.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';
import 'package:sensetal_presentation_design_app/theme/app_icons.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/space_widgets.dart';

class PainIntensityBottomSheetContent extends StatefulWidget {
  final String painAreaName; // Nome da área de dor selecionada
  final List<LastPainMeasureData> painData; // Dados históricos de dor
  const PainIntensityBottomSheetContent(
      {super.key, required this.painAreaName, required this.painData});

  @override
  State<PainIntensityBottomSheetContent> createState() =>
      _PainIntensityBottomSheetContentState();
}

class _PainIntensityBottomSheetContentState
    extends State<PainIntensityBottomSheetContent> {
  int? painLevelBottomSheetValue;
  String? painScaleBottomSheetValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título com nome da área selecionada
        Text(
          'Qual é o nível da dor no ${widget.painAreaName}?',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(),
        ),
        const VerticalSpace(size: AppSpaceSize.sm),
        // Container informativo sobre a dor
        Container(
          height: 76,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 156, 27, 27),
            borderRadius: AppBorderRadius.md,
          ),
          child: widget.painData.isNotEmpty
              ? const IconTextWidget(
                  iconPath: AppIcons.systemSensetalIconSmileyMeh,
                  text:
                      'Dor não diária, graduada por intensidade, mais ou menos intensa.',
                  iconPosition: 'left',
                )
              : const IconTextWidget(
                  iconPath: AppIcons.systemSensetalIconArrowDown,
                  text:
                      'Use o slider abaixo para indicar a intensidade da dor.',
                  iconPosition: 'left',
                ),
        ),
        const VerticalSpace(size: AppSpaceSize.sm),
        // Slider para selecionar intensidade da dor (0-10)
        CustomSlider(
          onChanged: (value) {
            setState(() {
              painLevelBottomSheetValue = value.toInt();
            });
          },
          min: 0,
          max: 10,
          activeTrackGradient: AppColors.gradientMain,
          inactiveTrackColor: AppColors.neutral05,
          thumbGradient: AppColors.gradientMain,
          thumbBorderColor: const Color.fromARGB(255, 231, 232, 241),
          thumbBorderWidth: 2,
          thumbRadius: 12,
          trackHeight: 8,
          textStyle: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.white),
        ),
        const VerticalSpace(size: AppSpaceSize.sm),
        // Título da seção de recorrência
        Text(
          'Qual a recorrência desta dor?',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(),
        ),
        const VerticalSpace(size: AppSpaceSize.sm),
        // Lista de opções exclusivas (aguda, crônica, etc)
        // Se houver dados de dor, exibe todas as opções
        // Caso contrário, exibe apenas as duas primeiras opções (aguda e crônica)
        widget.painData.isNotEmpty
            ? ExclusiveOptionsList(
                itensList: painLevelListItems,
                onTap: (value) {
                  setState(() {
                    painScaleBottomSheetValue = value[0];
                  });
                },
              )
            : ExclusiveOptionsList(
                itensList: [painLevelListItems[0], painLevelListItems[1]]),
        const VerticalSpace(size: AppSpaceSize.sm),

        // Título da seção de acompanhamento
        Text(
          'Acompanhamento dessa dor',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(),
        ),
        const VerticalSpace(size: AppSpaceSize.sm),

        // Se houver dados de dor, exibe os widgets de medida de dor
        SizedBox(
          child: widget.painData.isNotEmpty
              // Gera os widgets de medida de dor se houver histórico
              ? (Column(children: [
                  // Gera até 3 widgets de histórico de dor
                  ...List.generate(
                    // limita o numero maximo de históricos para 3
                    widget.painData.length < 3 ? widget.painData.length : 3,
                    (index) {
                      final data = widget.painData[index];
                      return Column(
                        children: [
                          LastPainMeasureWidget(data: data),
                          const VerticalSpace(size: AppSpaceSize.sm),
                        ],
                      );
                    },
                  ),
                  // Container com o card de análise da equipe de fisioterapeutas
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: AppBorderRadius.md,
                        color: AppColors.primary05),
                    padding: EdgeInsets.all(getSizeFromEnum(AppSpaceSize.md)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Título da análise
                        Text('Análise da equipe de fisioterapeutas',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: AppColors.neutral01,
                                    fontWeight: FontWeight.w600)),
                        const VerticalSpace(size: AppSpaceSize.xs),
                        const Divider(),
                        const VerticalSpace(size: AppSpaceSize.xs),
                        // Texto com feedback para o usuário
                        const Text(
                            'Excelente! A intensidade da dor está diminuindo, e seu corpo está respondendo bem aos treinos. Continue praticando para viver melhor e sem dores.')
                      ],
                    ),
                  ),
                ]))
              // Se não houver histórico, mostra mensagem informativa
              : const IconTextWidget(
                  iconPath: AppIcons.systemSensetalIconSensetal,
                  iconPosition: 'up',
                  text:
                      'À medida que você atualiza a intensidade da sua dor, a Sensetal faz o acompanhamento para você.',
                ),
        ),
        const VerticalSpace(size: AppSpaceSize.sm),

        // Botões de ação (Cancelar e Aplicar)
        Row(
          children: [
            Expanded(
              child: AppButton(
                buttonText: 'Cancelar',
                buttonType: AppButtonOptions.outline,
                onPressCallback: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PageAvaliacaoDor(),
                    ),
                  );
                },
              ),
            ),
            const HorizontalSpace(size: AppSpaceSize.md),
            Expanded(
              child: AppButton(
                buttonText: 'Aplicar',
                buttonType: AppButtonOptions.solid,
                onPressCallback: () {
                  if (painScaleBottomSheetValue != null &&
                      painLevelBottomSheetValue != null) {
                    Navigator.of(context).pop({
                      'label': widget.painAreaName,
                      'pain':
                          '$painLevelBottomSheetValue $painScaleBottomSheetValue'
                    });
                  } else {
                    Navigator.of(context).pop({});
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

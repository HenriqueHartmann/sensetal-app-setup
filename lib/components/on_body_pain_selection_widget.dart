// Import de pacotes e componentes necessários
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sensetal_presentation_design_app/components/exclusive_option_list.dart';
import 'package:sensetal_presentation_design_app/components/app_button.dart';
import 'package:sensetal_presentation_design_app/components/custom_slider.dart';
import 'package:sensetal_presentation_design_app/components/last_pain_measure_widget.dart';
import 'package:sensetal_presentation_design_app/pages/page_avaliacao_dor.dart';
import 'package:sensetal_presentation_design_app/theme/app_border_radius.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';
import 'package:sensetal_presentation_design_app/theme/app_icons.dart';
import 'package:sensetal_presentation_design_app/theme/app_images.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/space_widgets.dart';

// Constante para identificar o gênero masculino
const String genderMaleDBName = 'Masculino';

// Lista de coordenadas para pontos de dor no modelo masculino
// Cada ponto tem posição (top/left) em proporção à imagem (0-1) e um rótulo
List<Map<String, dynamic>> maleImageJointsCoordinates = [
  {'top': 0.153, 'left': 0.5, 'label': 'Pescoço'},
  {'top': 0.237, 'left': 0.5, 'label': 'Peito'},
  {'top': 0.434, 'left': 0.5, 'label': 'Barriga'},
  {'top': 0.208, 'left': 0.227, 'label': 'Ombro Direito'},
  {'top': 0.208, 'left': 0.773, 'label': 'Ombro Esquerdo'},
  {'top': 0.357, 'left': 0.153, 'label': 'Cotovelo Direito'},
  {'top': 0.357, 'left': 0.852, 'label': 'Cotovelo Esquerdo'},
  {'top': 0.49, 'left': 0.082, 'label': 'Mão Direita'},
  {'top': 0.49, 'left': 0.923, 'label': 'Mão Esquerda'},
  {'top': 0.473, 'left': 0.316, 'label': 'Perna Direita Superior'},
  {'top': 0.473, 'left': 0.669, 'label': 'Perna Esquerda Superior'},
  {'top': 0.694, 'left': 0.342, 'label': 'Joelho Direito'},
  {'top': 0.694, 'left': 0.65, 'label': 'Joelho Esquerdo'},
  {'top': 0.903, 'left': 0.323, 'label': 'Pé Direito'},
  {'top': 0.903, 'left': 0.678, 'label': 'Pé Esquerdo'},
];

// Lista de coordenadas para pontos de dor no modelo feminino
List<Map<String, dynamic>> femaleImageJointsCoordinates = [
  {'top': 0.175, 'left': 0.495, 'label': 'Pescoço'},
  {'top': 0.258, 'left': 0.495, 'label': 'Peito'},
  {'top': 0.45, 'left': 0.495, 'label': 'Barriga'},
  {'top': 0.23, 'left': 0.212, 'label': 'Ombro Direito'},
  {'top': 0.23, 'left': 0.775, 'label': 'Ombro Esquerdo'},
  {'top': 0.375, 'left': 0.135, 'label': 'Cotovelo Direito'},
  {'top': 0.375, 'left': 0.858, 'label': 'Cotovelo Esquerdo'},
  {'top': 0.505, 'left': 0.064, 'label': 'Mão Direita'},
  {'top': 0.505, 'left': 0.933, 'label': 'Mão Esquerda'},
  {'top': 0.489, 'left': 0.305, 'label': 'Perna Direita Superior'},
  {'top': 0.489, 'left': 0.669, 'label': 'Perna Esquerda Superior'},
  {'top': 0.704, 'left': 0.332, 'label': 'Joelho Direito'},
  {'top': 0.704, 'left': 0.65, 'label': 'Joelho Esquerdo'},
  {'top': 0.909, 'left': 0.314, 'label': 'Pé Direito'},
  {'top': 0.909, 'left': 0.678, 'label': 'Pé Esquerdo'},
];

// Lista de opções para o tipo de dor (aguda, crônica, etc)
List<ExclusiveOptionItem> painLevelListItems = [
  ExclusiveOptionItem(
      title: 'Aguda', subtitle: 'Dor repentina instantânea e pontual.'),
  ExclusiveOptionItem(
      title: 'Crônica', subtitle: 'Dor recorrente e permanente.'),
  ExclusiveOptionItem(
      title: 'Não sinto mais dores!',
      subtitle: 'Essa dor não me incomoda mais.'),
];

// Widget principal para seleção de pontos de dor no corpo
class OnBodyPainSelectionWidget extends StatefulWidget {
  final String gender; // Gênero para determinar qual modelo anatômico usar
  final List<LastPainMeasureData>?
      painData; // Dados históricos de dor (opcional)

  const OnBodyPainSelectionWidget(
      {super.key, required this.gender, this.painData});

  @override
  State<OnBodyPainSelectionWidget> createState() =>
      _OnBodyPainSelectionWidgetState();
}

class _OnBodyPainSelectionWidgetState extends State<OnBodyPainSelectionWidget> {
  bool _isFrontSide = true; // Controla se mostra frente ou costas do modelo

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SizedBox(
        child: Stack(
          children: [
            // Área central com o modelo anatômico e pontos clicáveis
            Center(
              child: ImageArea(
                  gender: widget.gender,
                  isFrontSide: _isFrontSide,
                  painData: widget.painData),
            ),
            // Botão para girar o modelo (alternar entre frente e costas)
            Positioned(
              left: 0,
              child: GestureDetector(
                onTap: () {
                  // Alterna entre frente e costas do modelo
                  _isFrontSide = !_isFrontSide;
                  setState(() {});
                },
                child: SizedBox(
                  height: 40,
                  width: 80,
                  child: Row(
                    children: [
                      // Botão circular com ícone para virar
                      Container(
                        width: 40,
                        height: 40,
                        padding:
                            EdgeInsets.all(getSizeFromEnum(AppSpaceSize.xs)),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary05,
                          border:
                              Border.all(color: AppColors.neutral05, width: 1),
                        ),
                        child: SvgPicture.asset(
                          AppIcons.systemSensetalIconClockwiseArrows,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const HorizontalSpace(size: AppSpaceSize.xs),
                      Text(
                        'Virar',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColors.neutral03),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Widget que renderiza o modelo anatômico com os pontos clicáveis
class ImageArea extends StatelessWidget {
  final String gender; // Gênero do modelo
  final bool isFrontSide; // Se mostra frente ou costas
  final List<LastPainMeasureData>? painData; // Dados históricos de dor

  const ImageArea(
      {super.key,
      required this.gender,
      required this.isFrontSide,
      this.painData});

  @override
  Widget build(BuildContext context) {
    // Usa LayoutBuilder para obter dimensões disponíveis e criar layout responsivo
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determina parâmetros baseados no gênero
        final bool isMale = gender == genderMaleDBName;
        // Calcula largura da imagem (proporção do espaço disponível)
        final double maxImageWidth =
            isMale ? constraints.maxWidth * 0.42 : constraints.maxWidth * 0.4;
        // Seleciona a imagem correta baseado no gênero e lado
        final image = isMale
            ? (isFrontSide ? AppImages.maleModelFront : AppImages.maleModelBack)
            : (isFrontSide
                ? AppImages.femaleModelFront
                : AppImages.femaleModelBack);
        // Seleciona o conjunto correto de coordenadas
        final clickAreaCoordinates =
            isMale ? maleImageJointsCoordinates : femaleImageJointsCoordinates;
        // Define a proporção de aspecto para manter as proporções corporais
        final double aspectRatio = isMale ? 3.195 : 3.375;
        final double imageWidth = maxImageWidth;
        final double imageHeight = imageWidth * aspectRatio;
        // Define o tamanho dos círculos clicáveis
        const double clickAreaDiameterSize = 35.0;

        return Center(
          child: SizedBox(
            width: imageWidth + clickAreaDiameterSize,
            height: imageHeight + 10,
            child: Stack(
              // Permite que elementos ultrapassem os limites do Stack
              clipBehavior: Clip.none,
              children: [
                // Imagem SVG do modelo anatômico
                Positioned(
                  left: clickAreaDiameterSize / 2,
                  top: clickAreaDiameterSize / 2,
                  child: SvgPicture.asset(
                    image,
                    width: imageWidth,
                    height: imageHeight,
                  ),
                ),
                // Gera os pontos clicáveis sobre o modelo
                ...clickAreaCoordinates.map(
                  (pos) => Positioned(
                    // Posiciona o ponto conforme coordenadas proporcionais
                    top: pos['top'] * imageHeight,
                    left: pos['left'] * imageWidth,
                    child: GestureDetector(
                      onTap: () {
                        // Ao clicar, mostra o bottom sheet para input de dor
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: AppColors.neutralWhite,
                          shape: const RoundedRectangleBorder(
                            borderRadius: AppBorderRadius.md,
                          ),
                          builder: (context) {
                            return SingleChildScrollView(
                              padding: EdgeInsets.all(
                                  getSizeFromEnum(AppSpaceSize.lg)),
                              child: PainIntensityBottomSheetContent(
                                painAreaName: pos['label'],
                                painData: painData ?? [],
                              ),
                            );
                          },
                        );
                      },
                      // Círculo visual que representa a área clicável
                      child: Container(
                        width: clickAreaDiameterSize,
                        height: clickAreaDiameterSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red.withOpacity(0.4),
                          border: Border.all(color: Colors.red, width: 2),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Widget que exibe o conteúdo do bottom sheet para informar intensidade da dor
class PainIntensityBottomSheetContent extends StatelessWidget {
  final String painAreaName; // Nome da área de dor selecionada
  final List<LastPainMeasureData> painData; // Dados históricos de dor
  const PainIntensityBottomSheetContent(
      {super.key, required this.painAreaName, required this.painData});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título com nome da área selecionada
        Text(
          'Qual é o nível da dor no $painAreaName?',
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
          child: painData.isNotEmpty
              ? const IconTextWidget(
                  iconPath: AppIcons.systemSensetalIconSmileyMeh,
                  text:
                      'Dor não diária, graduada por intensidade, mais ou menos intensa.',
                  position: 'left',
                )
              : const IconTextWidget(
                  iconPath: AppIcons.systemSensetalIconArrowDown,
                  text:
                      'Use o slider abaixo para indicar a intensidade da dor.',
                  position: 'left',
                ),
        ),
        const VerticalSpace(size: AppSpaceSize.sm),
        // Slider para selecionar intensidade da dor (0-10)
        CustomSlider(
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
        painData.isNotEmpty
            ? ExclusiveOptionsList(itensList: painLevelListItems)
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
          child: painData.isNotEmpty
              // Gera os widgets de medida de dor se houver histórico
              ? (Column(children: [
                  // Gera até 3 widgets de histórico de dor
                  ...List.generate(
                    // limita o numero maximo de históricos para 3
                    painData.length < 3 ? painData.length : 3,
                    (index) {
                      final data = painData[index];
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
              : IconTextWidget(
                  iconPath: AppIcons.systemSensetalIconSensetal,
                  text:
                      'À medida que você atualiza a intensidade da sua dor, a Sensetal faz o acompanhamento para você.',
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.neutral01),
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PageAvaliacaoDor(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Widget utilitário que combina um ícone e texto
class IconTextWidget extends StatelessWidget {
  final String iconPath; // Caminho para o arquivo SVG do ícone
  final String text; // Texto a ser exibido
  final String? position; // Posição do ícone ('left' ou null para topo)
  final TextStyle? textStyle; // Estilo opcional do texto
  final bool hasDivider; // Se deve incluir um divisor

  const IconTextWidget(
      {super.key,
      required this.iconPath,
      required this.text,
      this.position,
      this.textStyle,
      this.hasDivider = false});

  @override
  Widget build(BuildContext context) {
    // Função que gera o ícone
    icon() {
      return Container(
        width: 32,
        height: 32,
        padding: EdgeInsets.all(getSizeFromEnum(AppSpaceSize.xxs)),
        decoration: const BoxDecoration(
          color: AppColors.primary04,
          borderRadius: AppBorderRadius.sm,
        ),
        child: SvgPicture.asset(
          iconPath,
        ),
      );
    }

    // Retorna um container com ícone e texto na orientação desejada
    return Container(
        decoration: const BoxDecoration(
          color: AppColors.primary05,
          borderRadius: AppBorderRadius.md,
        ),
        padding: EdgeInsets.all(getSizeFromEnum(AppSpaceSize.md)),
        child: position == 'left'
            // Layout horizontal (ícone à esquerda do texto)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  icon(),
                  const HorizontalSpace(size: AppSpaceSize.md),
                  Expanded(
                      child: Text(
                    text,
                    style: textStyle,
                  ))
                ],
              )
            // Layout vertical (ícone acima do texto)
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  icon(),
                  const VerticalSpace(size: AppSpaceSize.md),
                  Text(
                    text,
                    style: textStyle,
                    textAlign: TextAlign.center,
                  )
                ],
              ));
  }
}

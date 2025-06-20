// Import de pacotes e componentes necessários
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sensetal_presentation_design_app/components/concentric_rectangles_with_text.dart';
import 'package:sensetal_presentation_design_app/components/exclusive_option_list.dart';
import 'package:sensetal_presentation_design_app/components/last_pain_measure_widget.dart';
import 'package:sensetal_presentation_design_app/components/on_body_pain_selection_components/bottom_sheet.dart';
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
  String? concentricText;

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
            ),
            // Exibe o texto com a escala de dor, se disponível
            if (concentricText != null)
              Positioned(
                // Defina a posição desejada
                child: ConcentricRectangles(text: concentricText!),
              ),
          ],
        ),
      ),
    );
  }
}

// Widget que renderiza o modelo anatômico com os pontos clicáveis
class ImageArea extends StatefulWidget {
  final String gender; // Gênero do modelo
  final bool isFrontSide; // Se mostra frente ou costas
  final List<LastPainMeasureData>? painData; // Dados históricos de dor

  const ImageArea({
    super.key,
    required this.gender,
    required this.isFrontSide,
    this.painData,
  });

  @override
  State<ImageArea> createState() => _ImageAreaState();
}

class _ImageAreaState extends State<ImageArea> {
  List<Map<String, String>> concentricText = [];

  @override
  Widget build(BuildContext context) {
    // Usa LayoutBuilder para obter dimensões disponíveis e criar layout responsivo
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determina parâmetros baseados no gênero
        final bool isMale = widget.gender == genderMaleDBName;
        // Calcula largura da imagem (proporção do espaço disponível)
        final double maxImageWidth =
            isMale ? constraints.maxWidth * 0.42 : constraints.maxWidth * 0.4;
        // Seleciona a imagem correta baseado no gênero e lado
        final image = isMale
            ? (widget.isFrontSide
                ? AppImages.maleModelFront
                : AppImages.maleModelBack)
            : (widget.isFrontSide
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
                    top: pos['top'] * imageHeight,
                    left: pos['left'] * imageWidth,
                    child: GestureDetector(
                      onTap: () async {
                        // Ao clicar, mostra o bottom sheet para input de dor
                        final result = await showModalBottomSheet(
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
                                painData: widget.painData ?? [],
                              ),
                            );
                          },
                        );

                        if (result != null &&
                            result['pain'] != null &&
                            result['label'] != null) {
                          setState(() {
                            concentricText.add({
                              'pain': result['pain'],
                              'label': result['label'],
                            });
                          });
                        }
                      },
                      child: Container(
                        key: Key(pos['label']),
                        width: clickAreaDiameterSize,
                        height: clickAreaDiameterSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // color: Colors.red.withOpacity(0.4),
                          // border: Border.all(color: Colors.red, width: 2),
                        ),
                      ),
                    ),
                  ),
                ),
                // Exibe o texto com a escala de dor, se disponível
                ...clickAreaCoordinates.map((pos) {
                  final painText = checkEmpty(concentricText, pos['label']);
                  if (painText != null) {
                    return Positioned(
                      top: pos['top'] * imageHeight,
                      left: pos['left'] * imageWidth,
                      child: ConcentricRectangles(
                        text: painText,
                        outerColor: painText[2] == 'A'
                            ? AppColors.error05
                            : AppColors.info05,
                        middleColor: painText[2] == 'A'
                            ? AppColors.error04
                            : AppColors.info04,
                        innerColor: painText[2] == 'A'
                            ? AppColors.error03
                            : AppColors.info03,
                        padding: 2,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),
                // Ao clicar, mostra o bottom sheet para input de dor
              ],
            ),
          ),
        );
      },
    );
  }
}

checkEmpty(List<Map<String, String>> concentricText, String label) {
  return concentricText.firstWhere((element) => element['label'] == label,
      orElse: () => {})['pain'];
}

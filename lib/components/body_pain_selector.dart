// Import de pacotes e componentes necessários
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sensetal_presentation_design_app/components/app_button.dart';
import 'package:sensetal_presentation_design_app/components/concentric_rectangles_with_text.dart';
import 'package:sensetal_presentation_design_app/components/custom_slider.dart';
import 'package:sensetal_presentation_design_app/components/exclusive_option_list.dart';
import 'package:sensetal_presentation_design_app/components/icon_text_widget.dart';
import 'package:sensetal_presentation_design_app/components/last_pain_measure_widget.dart';
import 'package:sensetal_presentation_design_app/components/on_body_pain_selection_components/persistent_enum.dart';
import 'package:sensetal_presentation_design_app/theme/app_border_radius.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';
import 'package:sensetal_presentation_design_app/theme/app_icons.dart';
import 'package:sensetal_presentation_design_app/theme/app_images.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/space_widgets.dart';

/// Constante que identifica o gênero masculino no banco de dados
/// Usada para determinar qual modelo anatômico e coordenadas utilizar
const String genderMaleDBName = 'Masculino';

/// Widget principal para seleção interativa de pontos de dor no corpo humano
///
/// Permite ao usuário:
/// - Visualizar modelo anatômico (masculino/feminino)
/// - Alternar entre vista frontal e posterior
/// - Clicar em pontos específicos para registrar dor
/// - Ver indicadores visuais das dores já registradas
///
/// Componentes principais:
/// - [ImageArea]: Renderiza modelo anatômico com pontos clicáveis
/// - Botão "Virar": Alterna entre frente e costas do modelo
/// - [ConcentricRectangles]: Indicadores visuais das dores registradas
class BodyPainSelector extends StatefulWidget {
  /// Gênero do usuário para determinar qual modelo anatômico usar
  /// Aceita valores como "Masculino" ou "Feminino"
  final String gender;

  /// Lista opcional de dados históricos de dor para contexto
  /// Usada para exibir informações de acompanhamento no bottom sheet
  final List<PainMeasureData>? painData;

  const BodyPainSelector({super.key, required this.gender, this.painData});

  @override
  State<BodyPainSelector> createState() => _BodyPainSelectorState();
}

class _BodyPainSelectorState extends State<BodyPainSelector> {
  /// Controla se o modelo está mostrando a frente (true) ou costas (false)
  /// Afeta qual imagem é exibida e como as coordenadas são interpretadas
  bool _isFrontSide = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          // Área central: modelo anatômico com pontos clicáveis
          Center(
            child: ImageArea(
              gender: widget.gender,
              isFrontSide: _isFrontSide,
              painData: widget.painData,
            ),
          ),

          // Botão de controle: alternar entre vista frontal e posterior
          Positioned(
            left: 0, // Posicionado no canto esquerdo
            child: GestureDetector(
              onTap: () {
                // Inverte o estado da visualização (frente ↔ costas)
                setState(() {
                  _isFrontSide = !_isFrontSide;
                });
              },
              child: SizedBox(
                height: 40,
                width: 80,
                child: Row(
                  children: [
                    // Ícone circular com setas de rotação
                    Container(
                      width: 40,
                      height: 40,
                      padding: EdgeInsets.all(getSizeFromEnum(AppSpaceSize.xs)),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary05, // Cor de fundo suave
                        border:
                            Border.all(color: AppColors.neutral05, width: 1),
                      ),
                      child: SvgPicture.asset(
                        AppIcons.systemSensetalIconClockwiseArrows,
                        fit: BoxFit.contain,
                      ),
                    ),

                    const HorizontalSpace(size: AppSpaceSize.xs),

                    // Label textual do botão
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
        ],
      ),
    );
  }
}

/// Widget que renderiza o modelo anatômico interativo com pontos clicáveis
///
/// Responsabilidades:
/// - Exibir imagem SVG do corpo humano (masculino/feminino, frente/costas)
/// - Posicionar pontos clicáveis sobre articulações/regiões do corpo
/// - Gerenciar o estado local das dores registradas
/// - Exibir indicadores visuais ([ConcentricRectangles]) das dores ativas
/// - Abrir bottom sheet para coleta de dados de dor
///
/// O layout é responsivo e se adapta às dimensões disponíveis mantendo
/// as proporções anatômicas corretas.
class ImageArea extends StatefulWidget {
  /// Gênero para determinar qual modelo anatômico usar
  final String gender;

  /// Controla se exibe vista frontal (true) ou posterior (false)
  final bool isFrontSide;

  /// Dados históricos opcionais para contexto no bottom sheet
  final List<PainMeasureData>? painData;

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
  /// Lista que mantém o registro local das dores inseridas pelo usuário
  ///
  /// Estrutura: [
  ///   {
  ///     'label': 'Nome da região (ex: Pescoço)',
  ///     'frontPain': 'Intensidade + Tipo (ex: 8 Aguda)', // quando vista frontal
  ///     'backPain': 'Intensidade + Tipo (ex: 5 Crônica)'  // quando vista posterior
  ///   }
  /// ]
  ///
  /// Permite que o usuário registre dores diferentes para frente e costas
  /// da mesma região corporal.
  List<Map<String, String>> painRegistryList = [];

  @override
  Widget build(BuildContext context) {
    // LayoutBuilder fornece as dimensões disponíveis para criar layout responsivo
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determina se deve usar modelo masculino baseado na string de gênero
        final bool isMale = widget.gender == genderMaleDBName;

        // Calcula largura máxima da imagem como proporção do espaço disponível
        // Modelos masculinos são ligeiramente mais largos que femininos
        final double maxImageWidth = isMale
            ? constraints.maxWidth * 0.42 // 42% para masculino
            : constraints.maxWidth * 0.4; // 40% para feminino

        // Seleciona a imagem SVG correta baseada no gênero e orientação
        final image = isMale
            ? (widget.isFrontSide
                ? AppImages.maleModelFront
                : AppImages.maleModelBack)
            : (widget.isFrontSide
                ? AppImages.femaleModelFront
                : AppImages.femaleModelBack);

        // Seleciona o conjunto de coordenadas dos pontos clicáveis
        // As coordenadas são normalizadas (0-1) em relação às dimensões da imagem
        final clickAreaCoordinates =
            isMale ? maleImageJointsCoordinates : femaleImageJointsCoordinates;

        // Define proporção de aspecto (altura/largura) para manter anatomia correta
        // Valores calculados baseados nas dimensões reais das imagens SVG
        final double aspectRatio = isMale ? 3.195 : 3.375;
        final double imageWidth = maxImageWidth;
        final double imageHeight = imageWidth * aspectRatio;

        // Tamanho padrão das áreas clicáveis (círculos invisíveis)
        const double clickAreaDiameterSize = 35;

        // Tamanho reservado para os indicadores de dor ([ConcentricRectangles])
        const double painScalePlaceHolderSize = 30;

        return Center(
          child: SizedBox(
            // Container principal que comporta a imagem + áreas clicáveis
            width: imageWidth + clickAreaDiameterSize,
            height: imageHeight + 10, // Margem adicional para indicadores
            child: Stack(
              //clipBehavior: Clip.none, // Permite elementos saírem dos limites
              children: [
                // Imagem SVG do modelo anatômico
                Positioned(
                  // Centraliza a imagem compensando o espaço das áreas clicáveis
                  left: clickAreaDiameterSize / 2,
                  //top: clickAreaDiameterSize / 2,
                  child: SvgPicture.asset(
                    image,
                    width: imageWidth,
                    height: imageHeight,
                  ),
                ),

// Renderiza indicadores visuais das dores registradas
                // Apenas para regiões que possuem dados para o lado atual
                ...clickAreaCoordinates.map(
                  (pos) {
                    // Busca se existe dor registrada para esta região no lado atual
                    final painText = getElement(
                        painRegistryList, pos['label'], widget.isFrontSide);

                    if (painText != null) {
                      // Extrai a primeira letra do tipo de dor do texto
                      // Formato esperado: "8 Aguda" ou "10 Crônica"
                      // Se intensidade = 10, compensa posição do caractere
                      final painScale = painText.length == 4
                          ? painText[3] // "10 A" -> 'A'
                          : painText[2]; // "8 A" -> 'A'

                      return Positioned(
                        // Centraliza o indicador subtraindo metade de suas dimensões
                        // para que o centro do indicador coincida com o centro do círculo azul
                        top: pos['top'] * imageHeight -
                            (painScalePlaceHolderSize / 2.5),
                        left: pos['left'] * imageWidth +
                            (painScalePlaceHolderSize / 10),
                        child: ConcentricRectangles(
                          text: painText, // Ex: "8 A" ou "10 C"
                          height: painScalePlaceHolderSize * 3 / 4,
                          width: painScalePlaceHolderSize,
                          // Determina cor baseada no tipo: A=Aguda, C=Crônica
                          painType: painScale == 'A' ? 'aguda' : 'cronica',
                          padding: 2,
                        ),
                      );
                    }
                    return const SizedBox.shrink(); // Widget vazio se sem dor
                  },
                ),

                // Gera dinamicamente os pontos clicáveis sobre o modelo
                // Cada coordenada do array se torna um GestureDetector posicionado
                ...clickAreaCoordinates.map(
                  (pos) => Positioned(
                    // Converte coordenadas normalizadas (0-1) para pixels
                    top: pos['top'] * imageHeight - (clickAreaDiameterSize / 2),
                    left: pos['left'] * imageWidth,
                    child: GestureDetector(
                      // Ação ao tocar: abre bottom sheet para coleta de dados
                      onTap: () async {
                        final result = await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true, // Permite altura dinâmica
                          backgroundColor: AppColors.neutralWhite,
                          shape: RoundedRectangleBorder(
                              borderRadius: AppBorderRadius.md),
                          builder: (context) {
                            return SingleChildScrollView(
                              padding: EdgeInsets.all(
                                getSizeFromEnum(AppSpaceSize.lg),
                              ),
                              child: PainIntensityBottomSheetContent(
                                painAreaName: pos[
                                    'label'], // Nome da região (ex: "Pescoço")
                                painData: widget.painData ??
                                    [], // Histórico para contexto
                              ),
                            );
                          },
                        );

                        // Processa o resultado retornado do bottom sheet
                        if (result != null && result['pain'] != null) {
                          // Determina qual lado está sendo visualizado
                          String imageSide =
                              widget.isFrontSide ? 'front' : 'back';

                          // Busca se já existe registro para esta região
                          final existingIndex = painRegistryList.indexWhere(
                              (element) => element['label'] == result['label']);

                          setState(() {
                            if (existingIndex != -1) {
                              // Atualiza registro existente para o lado atual
                              painRegistryList[existingIndex]
                                  ['${imageSide}Pain'] = result['pain'];
                            } else {
                              // Cria novo registro para esta região
                              painRegistryList.add({
                                'label': result['label'],
                                '${imageSide}Pain': result['pain'],
                              });
                            }
                          });
                        }
                      },

                      // Área clicável invisível sobre cada ponto anatômico
                      child: Container(
                        key: Key(pos['label']), // Key única para cada região
                        width: clickAreaDiameterSize,
                        height: clickAreaDiameterSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // Descomente as linhas abaixo para debug visual das áreas clicáveis:
                          // color: Colors.red.withOpacity(0.4),
                          // border: Border.all(color: Colors.red, width: 2),
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

/// Bottom Sheet modal para coleta detalhada de dados de dor
///
/// Fluxo de interação:
/// 1. Usuário seleciona intensidade (0-10) via slider
/// 2. Escolhe tipo de dor (Aguda/Crônica/Sem dor) via lista exclusiva
/// 3. Visualiza histórico e análises (se disponível)
/// 4. Confirma ou cancela a entrada
///
/// Componentes principais:
/// - [CustomSlider]: Seleção de intensidade 0-10
/// - [ExclusiveOptionsList]: Seleção do tipo de dor
/// - [LastPainMeasure]: Widgets de histórico (até 3)
/// - Card de análise profissional
/// - Botões de ação (Cancelar/Aplicar)
class PainIntensityBottomSheetContent extends StatefulWidget {
  /// Nome da região corporal selecionada (ex: "Pescoço", "Joelho Direito")
  final String painAreaName;

  /// Lista de dados históricos de dor para esta região
  /// Usada para exibir contexto e análises de evolução
  final List<PainMeasureData> painData;

  const PainIntensityBottomSheetContent(
      {super.key, required this.painAreaName, required this.painData});

  @override
  State<PainIntensityBottomSheetContent> createState() =>
      _PainIntensityBottomSheetContentState();
}

class _PainIntensityBottomSheetContentState
    extends State<PainIntensityBottomSheetContent> {
  /// Valor selecionado no slider de intensidade (0-10)
  /// null = nenhum valor selecionado ainda
  int? painLevelBottomSheetValue;

  /// Tipo de dor selecionado ("Aguda", "Crônica", "Não sinto mais dores!")
  /// null = nenhuma opção selecionada ainda
  String? painScaleBottomSheetValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Cabeçalho: título personalizado com nome da região
        Text(
          'Qual é o nível da dor em ${widget.painAreaName}?',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(),
        ),
        const VerticalSpace(size: AppSpaceSize.sm),

        // Card informativo: contextualiza o uso do slider
        Container(
          height: 76,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 156, 27, 27), // Cor de alerta/atenção
              borderRadius: AppBorderRadius.md),
          child: widget.painData.isNotEmpty
              // Se há histórico: mostra informação sobre variação da dor
              ? const IconTextWidget(
                  iconPath: AppIcons.systemSensetalIconSmileyMeh,
                  text:
                      'Dor não diária, graduada por intensidade, mais ou menos intensa.',
                  iconPosition: 'left',
                )
              // Se não há histórico: instrui sobre o uso do slider
              : const IconTextWidget(
                  iconPath: AppIcons.systemSensetalIconArrowDown,
                  text:
                      'Use o slider abaixo para indicar a intensidade da dor.',
                  iconPosition: 'left',
                ),
        ),
        const VerticalSpace(size: AppSpaceSize.sm),

        // Seção 1: Slider de intensidade (0-10)
        CustomSlider(
          onChanged: (value) {
            setState(() {
              painLevelBottomSheetValue = value.toInt();
            });
          },
          min: 0,
          max: 10,
          activeTrackGradient: AppColors.gradientMain, // Gradiente principal
          inactiveTrackColor: AppColors.neutral05, // Cor neutra
          thumbGradient: AppColors.gradientMain, // Thumb com gradiente
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

        // Seção 2: Título da seleção de recorrência
        Text(
          'Qual a recorrência desta dor?',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(),
        ),
        const VerticalSpace(size: AppSpaceSize.sm),

        // Lista de opções exclusivas para tipo de dor
        // Comportamento adaptativo baseado no histórico disponível
        ExclusiveOptionsList(
          itensList: widget.painData.isNotEmpty
              // Com histórico: todas as opções (incluindo "Não sinto mais dores!")
              ? painLevelListItems
              // Sem histórico: apenas Aguda e Crônica (primeiras 2 opções)
              : [painLevelListItems[0], painLevelListItems[1]],
          onTap: (value) {
            setState(() {
              painScaleBottomSheetValue =
                  value[0]; // Primeiro elemento do retorno
            });
          },
        ),
        const VerticalSpace(size: AppSpaceSize.sm),

        // Seção 3: Título da área de acompanhamento
        Text(
          'Acompanhamento dessa dor',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(),
        ),
        const VerticalSpace(size: AppSpaceSize.sm),

        // Área de histórico e análises
        SizedBox(
          child: widget.painData.isNotEmpty
              // Branch: Usuário com histórico de dor
              ? (Column(children: [
                  // Gera até 3 cards de histórico mais recente
                  ...List.generate(
                    // Limita exibição a máximo 3 registros para não sobrecarregar UI
                    widget.painData.length < 3 ? widget.painData.length : 3,
                    (index) {
                      final data = widget.painData[index];
                      return Column(
                        children: [
                          LastPainMeasure(
                              data: data), // Widget de gráfico individual
                          const VerticalSpace(size: AppSpaceSize.sm),
                        ],
                      );
                    },
                  ),

                  // Card de análise profissional da evolução
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: AppBorderRadius.md,
                        color: AppColors.primary05 // Cor de fundo suave
                        ),
                    padding: EdgeInsets.all(getSizeFromEnum(AppSpaceSize.md)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Título da seção de análise
                        Text('Análise da equipe de fisioterapeutas',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: AppColors.neutral01,
                                    fontWeight: FontWeight.w600)),
                        const VerticalSpace(size: AppSpaceSize.xs),
                        const Divider(), // Separador visual
                        const VerticalSpace(size: AppSpaceSize.xs),
                        const Text(
                            'Excelente! A intensidade da dor está diminuindo, e seu corpo está respondendo bem aos treinos. Continue praticando para viver melhor e sem dores.')
                      ],
                    ),
                  ),
                ]))
              // Branch: Usuário sem histórico (primeira vez)
              : const IconTextWidget(
                  iconPath: AppIcons.brandSensetalIcon,
                  iconPosition: 'top',
                  text:
                      'À medida que você atualiza a intensidade da sua dor, a Sensetal faz o acompanhamento para você.',
                ),
        ),
        const VerticalSpace(size: AppSpaceSize.sm),

        // Seção final: Botões de ação
        Row(
          children: [
            // Botão Cancelar: descarta entrada e fecha modal
            Expanded(
              child: AppButton(
                buttonText: 'Cancelar',
                buttonType: AppButtonOptions.outline,
                onPressCallback: () {
                  Navigator.of(context).pop(); // Fecha sem retornar dados
                },
              ),
            ),
            const HorizontalSpace(size: AppSpaceSize.md),

            // Botão Aplicar: valida e retorna dados coletados
            Expanded(
              child: AppButton(
                buttonText: 'Aplicar',
                buttonType: AppButtonOptions.solid,
                onPressCallback: () {
                  // Validação: ambos os valores devem estar preenchidos
                  if (painScaleBottomSheetValue != null &&
                      painLevelBottomSheetValue != null) {
                    // Retorna dados formatados para processamento
                    Navigator.of(context).pop({
                      'label': widget.painAreaName,
                      // Formato: "8 Aguda" ou "10 Crônica"
                      'pain':
                          '$painLevelBottomSheetValue $painScaleBottomSheetValue'
                    });
                  } else {
                    // Fecha sem dados se validação falhar
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

/// Função utilitária para buscar dados de dor específicos
///
/// Localiza na lista de registros de dor um item específico baseado na região
/// e lado (frontal/posterior) atual, retornando o texto formatado da dor.
///
/// Parâmetros:
/// - [painRegistryList]: Lista de registros de dor do usuário
/// - [label]: Nome da região corporal (ex: "Pescoço")
/// - [isFrontSide]: Se está visualizando lado frontal (true) ou posterior (false)
///
/// Retorna:
/// - String com dados da dor (ex: "8 Aguda") ou null se não encontrado
String? getElement(List<Map<String, String>> painRegistryList, String label,
    bool isFrontSide) {
  // Define chave de busca baseada no lado atual
  String imageSide = isFrontSide ? 'front' : 'back';

  // Busca item com label correspondente
  final Map<String, String> item = painRegistryList.firstWhere(
    (element) => element['label'] == label,
    orElse: () => {}, // Retorna mapa vazio se não encontrar
  );

  // Retorna valor para o lado específico ou null se não existir
  return item['${imageSide}Pain'];
}

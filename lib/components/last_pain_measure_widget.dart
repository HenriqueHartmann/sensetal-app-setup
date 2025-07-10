import 'package:flutter/material.dart';
import 'package:sensetal_presentation_design_app/theme/app_border_radius.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/space_widgets.dart';

/// Modelo de dados para representar informações de medição de dor
/// Contém histórico das últimas 5 medições, escala da dor e data da última medição
class PainMeasureData {
  final List<double>
      lastFivePainMeasure; // Últimas 5 medições de dor (valores de 0-10)
  final String painScale; // Tipo/escala da dor (ex: "Aguda", "Crônica")
  final DateTime lastPainMeasureDate; // Data da última medição registrada

  const PainMeasureData(
      {required this.lastFivePainMeasure,
      required this.painScale,
      required this.lastPainMeasureDate});
}

/// Widget principal que exibe um gráfico das últimas 5 medições de dor
/// Mostra a evolução da intensidade da dor ao longo do tempo
class LastPainMeasure extends StatelessWidget {
  final PainMeasureData data; // Dados da medição de dor

  const LastPainMeasure({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 112, // Altura fixa do card
      decoration: BoxDecoration(
        color: AppColors.primary05, // Cor de fundo do card
        borderRadius: AppBorderRadius.md,
      ),
      padding: EdgeInsets.all(
        getSizeFromEnum(AppSpaceSize.xs), // Padding interno do card
      ),
      child: Stack(
        children: [
          // Fundo destacado atrás do último ponto do gráfico
          GraphLastPointBackground(painLevel: data.lastFivePainMeasure.last),

          // Conteúdo principal do card
          Padding(
            padding: EdgeInsets.all(getSizeFromEnum(AppSpaceSize.xs)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Área esquerda do widget: informações textuais da última dor (intensidade e data)
                Expanded(
                  flex: 1,
                  child: LeftSideArea(
                    painScale: data.painScale,
                    lastPainMeasureDate: data.lastPainMeasureDate,
                  ),
                ),

                // Área central do widget: gráfico de linha com as ultimas 5 dores (2/3 da largura)
                Expanded(
                  flex: 2,
                  child: Center(
                    child: SizedBox(
                      height: 36, // Altura específica para o gráfico
                      width: double.infinity,
                      child: Container(
                        padding: EdgeInsets.only(
                            right: getSizeFromEnum(AppSpaceSize
                                .lg) // Espaço para o indicador do último valor
                            ),
                        child: GraphArea(
                            lastFivePainMeasure: data.lastFivePainMeasure),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget que renderiza o gráfico de linha das últimas 5 medições
/// Utiliza a biblioteca fl_chart para criar um gráfico responsivo
class GraphArea extends StatelessWidget {
  final List<double> lastFivePainMeasure; // Array de valores de dor (0-10)

  const GraphArea({super.key, required this.lastFivePainMeasure});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        maxY: 10, // Valor máximo do eixo Y (escala de dor 0-10)
        minY: 0, // Valor mínimo do eixo Y
        lineBarsData: [
          LineChartBarData(
            // Converte os valores em pontos do gráfico (x = índice, y = valor da dor)
            spots: [
              for (int i = 0; i < lastFivePainMeasure.length; i++)
                FlSpot(i.toDouble(), lastFivePainMeasure[i]),
            ],
            color: AppColors.primary02, // Cor da linha
            barWidth: 3, // Espessura da linha

            // Configuração dos pontos no gráfico
            dotData: FlDotData(
              getDotPainter: (spot, percent, barData, index) {
                // O último ponto tem cor diferente para destaque
                final isLast = spot.x == lastFivePainMeasure.length - 1;
                return FlDotCirclePainter(
                  radius: 2,
                  // Cor do último ponto : cor dos demais pontos
                  color: isLast ? AppColors.secondary02 : AppColors.primary02,
                  strokeColor: AppColors.primary02,
                  strokeWidth: 2,
                );
              },
            ),
          )
        ],
        // Remove títulos, grid e bordas para um visual mais limpo
        titlesData: FlTitlesData(show: false),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
      ),
    );
  }
}

/// Área lateral esquerda que exibe informações textuais
/// Mostra o tipo de dor (Aguda/Crônica) e a data da última medição
class LeftSideArea extends StatelessWidget {
  final String painScale; // Tipo da dor (ex: "Aguda", "Crônica")
  final DateTime lastPainMeasureDate; // Data da última medição

  const LeftSideArea(
      {super.key, required this.painScale, required this.lastPainMeasureDate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container com o texto do tipo de dor
        Container(
          decoration: BoxDecoration(
              borderRadius: AppBorderRadius.pill,
              color: AppColors.primary02 // Cor de fundo do container
              ),
          padding: EdgeInsets.symmetric(
            vertical: getSizeFromEnum(
                AppSpaceSize.custom, 2), // Padding vertical mínimo
            horizontal:
                getSizeFromEnum(AppSpaceSize.md), // Padding horizontal médio
          ),
          child: Text(painScale,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.secondary02, fontWeight: FontWeight.bold)),
        ),

        const VerticalSpace(
            size: AppSpaceSize.xs), // Espaçamento entre elementos

        // Data da última medição formatada
        Text(
          "${lastPainMeasureDate.day}/${lastPainMeasureDate.month}/${lastPainMeasureDate.year}",
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: AppColors.primary01),
        ),
      ],
    );
  }
}

/// Fundo destacado que aparece atrás do último ponto do gráfico
/// Exibe o valor médio da dor em uma área destacada
/// Posiciona o texto dinamicamente baseado no valor (acima ou abaixo)
class GraphLastPointBackground extends StatelessWidget {
  final double painLevel; // Nível atual da dor (último valor do array)

  const GraphLastPointBackground({super.key, required this.painLevel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Aplica espaçamento à direita para criar margem interna
      padding: EdgeInsets.only(right: getSizeFromEnum(AppSpaceSize.xs)),
      child: Align(
        alignment: Alignment.centerRight, // Alinha à direita do card
        child: Container(
            width: 48, // Largura fixa do indicador de 48 pixels
            height: 96, // Altura do indicador de 96 pixels
            decoration: BoxDecoration(
                color: AppColors
                    .primary04, // Cor de fundo mais clara para destaque
                borderRadius: AppBorderRadius.sm),
            // Implementa lógica de posicionamento inteligente do texto:
            // - Se o nível de dor > 5: posiciona texto no topo (evita sobreposição com linha alta)
            // - Se o nível de dor ≤ 5: posiciona texto embaixo (evita sobreposição com linha baixa)
            // Isso garante melhor legibilidade independente do valor da dor
            child: (painLevel > 5)
                ? DrawTextInPosition(
                    lastPainMeasure: painLevel,
                    position: 'down', // Posição inferior para valores altos
                  )
                : DrawTextInPosition(
                    lastPainMeasure: painLevel,
                    position: 'top' // Posição superior para valores baixos
                    )),
      ),
    );
  }
}

/// Widget auxiliar que renderiza o texto do indicador de dor em diferentes posições
/// Responsável por exibir a média do valor numérico da dor
/// Adapta o layout vertical baseado na posição especificada ('top' ou 'down')
class DrawTextInPosition extends StatelessWidget {
  final double lastPainMeasure; // Valor da última medição de dor
  final String
      position; // Posição a média: 'top' (superior) ou 'down' (inferior)

  const DrawTextInPosition(
      {super.key, required this.lastPainMeasure, required this.position});

  @override
  Widget build(BuildContext context) {
    return Column(
      // Define o alinhamento vertical baseado na posição:
      // - 'top': alinha ao final (parte inferior da coluna)
      // - 'down': alinha ao início (parte superior da coluna)
      mainAxisAlignment:
          position == 'down' ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        // Espaçamento superior mínimo
        SizedBox(height: getSizeFromEnum(AppSpaceSize.xxs)),

        // Rótulo "Média"
        Text("Média",
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.primary01, // Cor do texto secundária
                )),

        // Container com o valor numérico da dor
        Container(
          decoration: BoxDecoration(
              borderRadius: AppBorderRadius.sm,
              color: AppColors.secondary02 // Cor de fundo destacada
              ),
          padding: EdgeInsets.symmetric(
            horizontal:
                getSizeFromEnum(AppSpaceSize.sm), // Padding horizontal médio
          ),
          child: Text(
              lastPainMeasure
                  .toInt()
                  .toString(), // Converte para inteiro e exibe
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.primary02, // Cor do texto principal
                  fontWeight: FontWeight.bold // Peso da fonte em negrito
                  )),
        ),

        // Espaçamento inferior mínimo
        SizedBox(height: getSizeFromEnum(AppSpaceSize.xxs)),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sensetal_presentation_design_app/theme/app_border_radius.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';

// Contem os 5 ultimos valores de dor para o grafico
class PainUniqueMeasureWidget extends StatelessWidget {
  final List<double> lastFivePainMeasure; // Ultimos 5 medicoes de dor
  final String painScale; // Escala da dor texto
  final DateTime lastPainMeasureDate; // Data da ultima medicao de dor

  const PainUniqueMeasureWidget(
      {super.key,
      required this.lastFivePainMeasure,
      required this.painScale,
      required this.lastPainMeasureDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 112,
      decoration: const BoxDecoration(
        color: AppColors.primary05,
        borderRadius: AppBorderRadius.md,
      ),
      padding: EdgeInsets.all(
        getSizeFromEnum(AppSpaceSize.xs),
      ),
      child: Stack(
        children: [
          GraphLastPointBackground(painLevel: lastFivePainMeasure.last),
          Padding(
            padding: EdgeInsets.all(getSizeFromEnum(AppSpaceSize.xs)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: LeftSideArea(
                    painScale: this.painScale,
                    lastPainMeasureDate: this.lastPainMeasureDate,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: SizedBox(
                      height: 36,
                      width: double.infinity,
                      child: Container(
                        padding: EdgeInsets.only(
                            right: getSizeFromEnum(AppSpaceSize.lg)),
                        child:
                            GraphArea(lastFivePainMeasure: lastFivePainMeasure),
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

// Gera o grafico do widget
class GraphArea extends StatelessWidget {
  final List<double> lastFivePainMeasure;
  const GraphArea({super.key, required this.lastFivePainMeasure});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        maxY: 10,
        minY: 0,
        lineBarsData: [
          LineChartBarData(
            spots: [
              for (int i = 0; i < lastFivePainMeasure.length; i++)
                FlSpot(i.toDouble(), lastFivePainMeasure[i]),
            ],
            color: AppColors.primary02,
            barWidth: 3,
            dotData: FlDotData(
              getDotPainter: (spot, percent, barData, index) {
                final isLast = spot.x == lastFivePainMeasure.length - 1;
                return FlDotCirclePainter(
                  radius: 2,
                  color: isLast ? AppColors.secondary02 : AppColors.primary02,
                  strokeColor: AppColors.primary02,
                  strokeWidth: 2,
                );
              },
            ),
          )
        ],
        titlesData: const FlTitlesData(show: false),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(
          show: false,
        ),
      ),
    );
  }
}

// Gera a area lateral esquerda do grafico
class LeftSideArea extends StatelessWidget {
  final String painScale;
  final DateTime lastPainMeasureDate;
  const LeftSideArea(
      {super.key, required this.painScale, required this.lastPainMeasureDate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container com o texto da dor e data
        Container(
          decoration: const BoxDecoration(
              borderRadius: AppBorderRadius.pill, color: AppColors.primary02),
          padding: EdgeInsets.symmetric(
            vertical: 2,
            horizontal: getSizeFromEnum(AppSpaceSize.md),
          ),
          child: Text(painScale,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.secondary02, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: getSizeFromEnum(AppSpaceSize.xs),
        ),
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

// Gera o fundo azul atrás do último ponto do gráfico
class GraphLastPointBackground extends StatelessWidget {
  final double painLevel;
  const GraphLastPointBackground({super.key, required this.painLevel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: getSizeFromEnum(AppSpaceSize.xs)),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          width: 48,
          height: 96,
          decoration: const BoxDecoration(
            color: AppColors.primary04,
            borderRadius: AppBorderRadius.sm,
          ),
          // ignore: unnecessary_this
          child: (this.painLevel > 5)
              // ignore: unnecessary_this
              ? TextAbove(lastPainMeasure: this.painLevel)
              : TextBelow(lastPainMeasure: painLevel),
        ),
      ),
    );
  }
}

// Se o valor for menor que 5, o texto fica acima do gráfico
class TextAbove extends StatelessWidget {
  final double lastPainMeasure;
  const TextAbove({super.key, required this.lastPainMeasure});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text("Média",
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.primary01,
                )),
        Container(
          decoration: const BoxDecoration(
              borderRadius: AppBorderRadius.sm, color: AppColors.secondary02),
          padding: EdgeInsets.symmetric(
            horizontal: getSizeFromEnum(AppSpaceSize.sm),
          ),
          child: Text(lastPainMeasure.toInt().toString(),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.primary02, fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: getSizeFromEnum(AppSpaceSize.xs)),
      ],
    );
  }
}

// Se o valor for maior que 5, o texto fica embaixo do gráfico
class TextBelow extends StatelessWidget {
  final double lastPainMeasure;
  const TextBelow({super.key, required this.lastPainMeasure});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: getSizeFromEnum(AppSpaceSize.xs)),
      Text("Média",
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.primary01,
              )),
      Container(
        decoration: const BoxDecoration(
            borderRadius: AppBorderRadius.sm, color: AppColors.secondary02),
        padding: EdgeInsets.symmetric(
          horizontal: getSizeFromEnum(AppSpaceSize.sm),
        ),
        child: Text(lastPainMeasure.toInt().toString(),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.primary02, fontWeight: FontWeight.bold)),
      )
    ]);
  }
}

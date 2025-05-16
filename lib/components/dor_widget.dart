import 'package:flutter/material.dart';
import 'package:sensetal_presentation_design_app/theme/app_border_radius.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';

// Contem os 5 ultimos valores de dor para o grafico
const List<double> grauDor = [1, 2, 5, 10, 10];

class DorWidget extends StatelessWidget {
  const DorWidget({super.key});

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
          const FundoUltimoPontoGrafico(),
          Padding(
            padding: EdgeInsets.all(getSizeFromEnum(AppSpaceSize.xs)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  flex: 1,
                  child: AreaLateralEsquerda(),
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
                        child: const AreaGrafico(),
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
class AreaGrafico extends StatelessWidget {
  const AreaGrafico({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: [
              for (int i = 0; i < grauDor.length; i++)
                FlSpot(i.toDouble(), grauDor[i]),
            ],
            color: AppColors.primary02,
            barWidth: 3,
            dotData: FlDotData(
              getDotPainter: (spot, percent, barData, index) {
                final isLast = spot.x == grauDor.length - 1;
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
class AreaLateralEsquerda extends StatelessWidget {
  const AreaLateralEsquerda({super.key});

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
          child: Text('Aguda',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.secondary02, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: getSizeFromEnum(AppSpaceSize.xs),
        ),
        Text(
          '28/03/2025',
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
class FundoUltimoPontoGrafico extends StatelessWidget {
  const FundoUltimoPontoGrafico({super.key});

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
          child: (grauDor[4] > 5) ? const TextoNoAlto() : const TextoEmBaixo(),
        ),
      ),
    );
  }
}

// Se o valor for menor que 5, o texto fica acima do gráfico
class TextoNoAlto extends StatelessWidget {
  const TextoNoAlto({super.key});
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
            vertical: 2,
            horizontal: getSizeFromEnum(AppSpaceSize.sm),
          ),
          child: Text(grauDor[4].toInt().toString(),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.primary02, fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: getSizeFromEnum(AppSpaceSize.xs)),
      ],
    );
  }
}

// Se o valor for maior que 5, o texto fica embaixo do gráfico
class TextoEmBaixo extends StatelessWidget {
  const TextoEmBaixo({super.key});
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
          vertical: 2,
          horizontal: getSizeFromEnum(AppSpaceSize.sm),
        ),
        child: Text(grauDor[4].toInt().toString(),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.primary02, fontWeight: FontWeight.bold)),
      )
    ]);
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sensetal_presentation_design_app/pages/page_login.dart';
import 'package:sensetal_presentation_design_app/theme/app_border_radius.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';

// Contem as datas correspondentes aos 5 ultimos valores de dor para o grafico
const List<String> datas = [
  "01/01/2001",
  "02/02/2002",
  "03/03/2003",
  "04/04/2004",
  "05/05/2005",
];

const List<double> grauDor = [10, 5, 6, 0, 10];

const String areaDor = 'Lombar';

class GraficoIntensidadeDor extends StatelessWidget {
  const GraficoIntensidadeDor({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primary05,
        borderRadius: AppBorderRadius.md,
      ),
      height: 190,
      padding: EdgeInsets.all(
        getSizeFromEnum(AppSpaceSize.md) - 3,
      ),
      child: Column(
        children: [
          const AreaSuperior(),
          SizedBox(
            height: getSizeFromEnum(AppSpaceSize.md),
          ),
          const Divider(
            color: AppColors.primary04,
            thickness: 1,
            height: 1,
          ),
          Container(
              padding: EdgeInsets.only(
                top: getSizeFromEnum(AppSpaceSize.md),
              ),
              width: double.infinity,
              child: const AreaFundo()),
          //const AreaDatas()
        ],
      ),
    );
  }
}

class AreaSuperior extends StatelessWidget {
  const AreaSuperior({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const PageLogin()));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Dor na $areaDor",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.primary01,
                ),
          ),
          Row(
            children: [
              Text(
                'Atualizar',
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.primary02,
                    ),
              ),
              SizedBox(
                width: getSizeFromEnum(AppSpaceSize.xs),
              ),
              const Icon(
                Icons.keyboard_arrow_right_rounded,
                color: AppColors.neutral04,
                size: 18,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Grafico extends StatelessWidget {
  const Grafico({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: getSizeFromEnum(AppSpaceSize.xxl) + 12,
        right: getSizeFromEnum(AppSpaceSize.lg) + 1,
        left: getSizeFromEnum(AppSpaceSize.lg) + 1,
      ),
      height: 67,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: [
                for (int i = 0; i < grauDor.length; i++)
                  FlSpot(i.toDouble(), grauDor[i]),
              ],
              color: AppColors.primary03,
              barWidth: 1,
              dotData: FlDotData(
                getDotPainter: (spot, percent, barData, index) {
                  final isLast = spot.x == grauDor.length - 1;
                  final isFirst = spot.x == 0;
                  return FlDotCirclePainter(
                    radius: isLast ? 3 : 2,
                    color: isFirst
                        ? AppColors.error02
                        : (isLast
                            ? AppColors.secondary02
                            : AppColors.primary03),
                    strokeColor:
                        isFirst ? AppColors.error02 : AppColors.primary03,
                    strokeWidth: isLast ? 3 : 2,
                  );
                },
              ),
            )
          ],
          titlesData: const FlTitlesData(show: false),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}

class AreaFundo extends StatelessWidget {
  const AreaFundo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const FundoUltimoPontoGrafico(),
            // Distancia entre fundo do grafico e lateral direita
            SizedBox(width: getSizeFromEnum(AppSpaceSize.xs) + 1)
          ],
        ),
        const ValoresPontosData(),
        const Grafico(),
      ],
    );
  }
}

class FundoUltimoPontoGrafico extends StatelessWidget {
  const FundoUltimoPontoGrafico({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 78,
      decoration: const BoxDecoration(
        color: AppColors.primary02,
        borderRadius: AppBorderRadius.sm,
      ),
    );
  }
}

class ValoresPontosData extends StatelessWidget {
  const ValoresPontosData({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: getSizeFromEnum(AppSpaceSize.xxs)),
      height: 103,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          grauDor.length,
          (index) {
            final isLast = index == grauDor.length - 1;
            return SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    (grauDor[index]).toInt().toString(),
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: isLast ? Colors.white : AppColors.primary03,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  isLast
                      ? Column(
                          children: [
                            Text(
                              'nível',
                              textAlign: TextAlign.right,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    color: isLast
                                        ? Colors.white
                                        : AppColors.primary03,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 35),
                          ],
                        )
                      : const SizedBox(
                          height: 53,
                        ),
                  Text(
                    datas[index],
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: index == datas.length - 1
                              ? AppColors.primary02
                              : AppColors.primary03,
                          fontWeight: FontWeight.bold,
                        ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

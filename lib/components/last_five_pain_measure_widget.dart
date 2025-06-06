import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sensetal_presentation_design_app/pages/page_avaliacao_dor.dart';
import 'package:sensetal_presentation_design_app/theme/app_border_radius.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';
import 'package:sensetal_presentation_design_app/theme/app_icons.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/space_widgets.dart';

class LastFivePainMeasureWidget extends StatelessWidget {
  final List<double> lastFivePainMeasure;
  final String painAreaName;
  final List<DateTime> lastFivePainMeasureDate;
  const LastFivePainMeasureWidget(
      {super.key,
      required this.lastFivePainMeasure,
      required this.painAreaName,
      required this.lastFivePainMeasureDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primary05,
        borderRadius: AppBorderRadius.md,
      ),
      height: 190,
      padding: EdgeInsets.all(
        getSizeFromEnum(AppSpaceSize.custom, 13.0),
      ),
      child: Column(
        children: [
          TopArea(
            painAreaName: this.painAreaName,
          ),
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
            child: BackArea(
              lastFivePainMeasure: this.lastFivePainMeasure,
              lastFivePainMeasureDate: this.lastFivePainMeasureDate,
            ),
          ),
          //const AreaDatas()
        ],
      ),
    );
  }
}

class TopArea extends StatelessWidget {
  final String painAreaName;
  const TopArea({super.key, required this.painAreaName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const PageAvaliacaoDor()));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Dor na $painAreaName",
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
              const HorizontalSpace(size: AppSpaceSize.xs),
              SvgPicture.asset(
                AppIcons.systemSensetalIconCaretRight,
                width: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GraphArea extends StatelessWidget {
  final List<double> lastFivePainMeasure;
  const GraphArea({super.key, required this.lastFivePainMeasure});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: getSizeFromEnum(AppSpaceSize.custom, 52.0),
        right: getSizeFromEnum(AppSpaceSize.custom, 25.0),
        left: getSizeFromEnum(AppSpaceSize.custom, 25.0),
      ),
      height: 67,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: [
                for (int i = 0; i < lastFivePainMeasure.length; i++)
                  FlSpot(i.toDouble(), lastFivePainMeasure[i]),
              ],
              color: AppColors.primary03,
              barWidth: 1,
              dotData: FlDotData(
                getDotPainter: (spot, percent, barData, index) {
                  final isLast = spot.x == lastFivePainMeasure.length - 1;
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

class BackArea extends StatelessWidget {
  final List<double> lastFivePainMeasure;
  final List<DateTime> lastFivePainMeasureDate;
  const BackArea(
      {super.key,
      required this.lastFivePainMeasure,
      required this.lastFivePainMeasureDate});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GraphLastPointBackground(),
            // Distancia entre fundo do grafico e lateral direita
            HorizontalSpace(size: AppSpaceSize.custom, custom: 9.0)
          ],
        ),
        DatePainMeasureValues(
          lastFivePainMeasure: this.lastFivePainMeasure,
          lastFivePainMeasureDate: this.lastFivePainMeasureDate,
        ),
        GraphArea(
          lastFivePainMeasure: this.lastFivePainMeasure,
        ),
      ],
    );
  }
}

class GraphLastPointBackground extends StatelessWidget {
  const GraphLastPointBackground({super.key});

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

class DatePainMeasureValues extends StatelessWidget {
  final List<double> lastFivePainMeasure;
  final List<DateTime> lastFivePainMeasureDate;
  const DatePainMeasureValues(
      {super.key,
      required this.lastFivePainMeasure,
      required this.lastFivePainMeasureDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: getSizeFromEnum(AppSpaceSize.xxs),
          left: getSizeFromEnum(AppSpaceSize.custom, 5.0),
          right: getSizeFromEnum(AppSpaceSize.custom, 5.0)),
      height: 103,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          lastFivePainMeasure.length,
          (index) {
            final isLast = index == lastFivePainMeasure.length - 1;
            return SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    (lastFivePainMeasure[index]).toInt().toString(),
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
                            const VerticalSpace(
                                size: AppSpaceSize.custom, custom: 35.0),
                          ],
                        )
                      : const VerticalSpace(
                          size: AppSpaceSize.custom, custom: 53.0),
                  Text(
                    '${lastFivePainMeasureDate[index].day}/${lastFivePainMeasureDate[index].month}/${lastFivePainMeasureDate[index].year}',
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: index == lastFivePainMeasureDate.length - 1
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

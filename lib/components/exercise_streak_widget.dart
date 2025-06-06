import 'package:flutter/material.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';
import 'package:sensetal_presentation_design_app/utils/day_weekday_map_utils.dart';

class ExerciseStreakWidget extends StatelessWidget {
  final List<double> lastThreeDaysExecution;
  const ExerciseStreakWidget({super.key, required this.lastThreeDaysExecution});

  @override
  Widget build(BuildContext context) {
    final weekDays = defineWeekDays(3);

    return Stack(
      children: [
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primary02,
              borderRadius: BorderRadius.circular(8),
            ),
            height: 58,
            width: 32,
            padding: EdgeInsets.all(getSizeFromEnum(AppSpaceSize.xs)),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (index) {
            final dayInfo = weekDays[index];
            // verifica se o usuario executou o exercicio apenas nos 3 valores do indice, caso contrario retorna -1 evitando erro de indice inexistente
            // se o valor for -1, significa que o dia é o atual ou os 3 próximos
            final hasExecuted = index < 3 ? lastThreeDaysExecution[index] : -1;
            final isCentral = index == 3;

            return SizedBox(
              width: 30,
              height: 58,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dayInfo.day.toString(),
                    // verifica se o dia é o central e muda a cor do texto
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: isCentral
                            ? AppColors.error05
                            : AppColors.primary03),
                  ),
                  Icon(
                    Icons.circle_rounded,
                    // verifica se o usuario executou o exercicio e muda a cor do icone

                    color: hasExecuted != -1
                        ? ((hasExecuted == 1)
                            ? AppColors.success02
                            : AppColors.error02)
                        : AppColors.neutral05,
                    size: 4,
                  ),
                  Text(
                    dayInfo.dayWeek.toString(),
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: isCentral
                            ? AppColors.error05
                            : AppColors.primary03),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}

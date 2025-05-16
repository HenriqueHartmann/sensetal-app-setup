import 'package:flutter/material.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';

class ExerciseStreakWidget extends StatelessWidget {
  final List<double> lastThreeDaysExecution;
  const ExerciseStreakWidget({super.key, required this.lastThreeDaysExecution});

  @override
  Widget build(BuildContext context) {
    final weekDays = defineWeekDays();

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
            padding: const EdgeInsets.all(8),
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
                    dayInfo['day'] ?? '',
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
                    dayInfo['weekDay'] ?? '',
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

// Função que retorna os dias da semana em relação ao dia atual
List<Map<String, String>> defineWeekDays() {
  final todayDate = DateTime.now();
  final List<String> daysOfWeek = [
    'Dom',
    'Seg',
    'Ter',
    'Qua',
    'Qui',
    'Sex',
    'Sáb'
  ];

  return List.generate(7, (i) {
    final day = todayDate.add(Duration(days: i - 3)).day.toString();
    final dayWeek = daysOfWeek[
        todayDate.add(Duration(days: i - 3)).weekday % 7]; // 1=Seg, 7=Dom

    return {
      'day': day,
      'weekDay': dayWeek,
    };
  });
}

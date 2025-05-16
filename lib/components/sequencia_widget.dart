import 'package:flutter/material.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';

// recebe os últimos 3 dias + hoje + próximos 3 dias
const List<double> executouExercicio = [1, 1, 1, -1, -1, -1, -1];

class SequenciaWidget extends StatelessWidget {
  const SequenciaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final dias = diasAoRedor();

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
            final diaInfo = dias[index];
            final executou = executouExercicio[index];
            final eCentral = index == 3;

            return SizedBox(
              width: 30,
              height: 58,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    diaInfo['dia'] ?? '',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color:
                            eCentral ? AppColors.error05 : AppColors.primary03),
                  ),
                  Icon(
                    Icons.circle_rounded,
                    color: (executou == -1)
                        ? AppColors.neutral05
                        : ((executou == 1)
                            ? AppColors.success02
                            : AppColors.error02),
                    size: 4,
                  ),
                  Text(
                    diaInfo['diaSemana'] ?? '',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color:
                            eCentral ? AppColors.error05 : AppColors.primary03),
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

List<Map<String, String>> diasAoRedor() {
  //final dataBase = DateTime(2025, 01, 01);
  final dataBase = DateTime.now();
  final List<String> diasSemana = [
    'Dom',
    'Seg',
    'Ter',
    'Qua',
    'Qui',
    'Sex',
    'Sáb'
  ];

  return List.generate(7, (i) {
    final data = dataBase.add(Duration(days: i - 3));
    final diaFormatado = data.day.toString().padLeft(2, '0');
    final nomeDia = diasSemana[data.weekday % 7]; // 1=Seg, 7=Dom

    return {
      'dia': diaFormatado,
      'diaSemana': nomeDia,
    };
  });
}

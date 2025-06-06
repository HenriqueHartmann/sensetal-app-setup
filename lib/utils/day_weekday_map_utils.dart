/// Representa um dia do mês como string.
/// Exemplo: "3", "21", "15"
class Day {
  final String day;

  /// Construtor que exige o valor do dia.
  Day({required this.day});

  /// Retorna o valor do dia como string.
  @override
  String toString() {
    return day;
  }
}

/// Representa o dia da semana (ex: "Seg", "Ter", etc.).
class DayWeek {
  final String name;

  /// Construtor que exige o nome do dia da semana.
  DayWeek({required this.name});

  /// Retorna o nome do dia da semana.
  @override
  String toString() {
    return name;
  }
}

/// Agrupa um dia do mês com seu respectivo dia da semana.
/// Exemplo: "3" (Day) e "Qua" (DayWeek)
class DayInfo {
  final Day day;
  final DayWeek dayWeek;

  /// Construtor que exige tanto o dia quanto o dia da semana.
  DayInfo({required this.day, required this.dayWeek});
}

/// Gera uma lista de 7 dias consecutivos (uma semana),
/// começando a partir de um `offset` em relação ao dia atual.
///
/// [offset] é a posição do dia "central" (ex: se for 3, o dia atual é o 4º da lista)
///
/// Exemplo de uso:
/// ```dart
/// final semana = defineWeekDays(3);
/// for (var d in semana) {
///   print('${d.dayWeek} - ${d.day}');
/// }
/// ```
///
/// Isso imprimirá 7 dias ao redor do dia atual, começando do dia atual menos `offset`.
List<DayInfo> defineWeekDays(int offset) {
  final todayDate = DateTime.now();

  /// Nomes abreviados dos dias da semana em ordem (Dom -> Sáb)
  final List<String> daysOfWeek = [
    'Dom',
    'Seg',
    'Ter',
    'Qua',
    'Qui',
    'Sex',
    'Sáb'
  ];

  /// Cria a lista de 7 dias a partir do dia atual menos o offset
  return List.generate(7, (i) {
    final date = todayDate.add(Duration(days: i - offset));
    final day = Day(day: date.day.toString());
    final dayWeek = DayWeek(name: daysOfWeek[date.weekday - 1]);

    return DayInfo(day: day, dayWeek: dayWeek);
  });
}

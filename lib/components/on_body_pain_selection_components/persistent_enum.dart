// Lista de coordenadas para pontos de dor no modelo masculino
// Cada ponto tem posição (top/left) em proporção à imagem (0-1) e um rótulo
import 'package:sensetal_presentation_design_app/components/exclusive_option_list.dart';

List<Map<String, dynamic>> maleImageJointsCoordinates = [
  {'top': 0.150, 'left': 0.505, 'label': 'Pescoço'},
  {'top': 0.236, 'left': 0.505, 'label': 'Peito'},
  {'top': 0.434, 'left': 0.505, 'label': 'Barriga'},
  {'top': 0.206, 'left': 0.229, 'label': 'Ombro Direito'},
  {'top': 0.206, 'left': 0.777, 'label': 'Ombro Esquerdo'},
  {'top': 0.356, 'left': 0.153, 'label': 'Cotovelo Direito'},
  {'top': 0.356, 'left': 0.859, 'label': 'Cotovelo Esquerdo'},
  {'top': 0.49, 'left': 0.082, 'label': 'Mão Direita'},
  {'top': 0.49, 'left': 0.928, 'label': 'Mão Esquerda'},
  {'top': 0.473, 'left': 0.317, 'label': 'Perna Direita Superior'},
  {'top': 0.473, 'left': 0.673, 'label': 'Perna Esquerda Superior'},
  {'top': 0.695, 'left': 0.343, 'label': 'Joelho Direito'},
  {'top': 0.695, 'left': 0.655, 'label': 'Joelho Esquerdo'},
  {'top': 0.906, 'left': 0.325, 'label': 'Pé Direito'},
  {'top': 0.906, 'left': 0.683, 'label': 'Pé Esquerdo'},
];

// Lista de coordenadas para pontos de dor no modelo feminino
List<Map<String, dynamic>> femaleImageJointsCoordinates = [
  {'top': 0.175, 'left': 0.495, 'label': 'Pescoço'},
  {'top': 0.258, 'left': 0.495, 'label': 'Peito'},
  {'top': 0.45, 'left': 0.495, 'label': 'Barriga'},
  {'top': 0.23, 'left': 0.212, 'label': 'Ombro Direito'},
  {'top': 0.23, 'left': 0.775, 'label': 'Ombro Esquerdo'},
  {'top': 0.375, 'left': 0.135, 'label': 'Cotovelo Direito'},
  {'top': 0.375, 'left': 0.858, 'label': 'Cotovelo Esquerdo'},
  {'top': 0.505, 'left': 0.064, 'label': 'Mão Direita'},
  {'top': 0.505, 'left': 0.933, 'label': 'Mão Esquerda'},
  {'top': 0.489, 'left': 0.305, 'label': 'Perna Direita Superior'},
  {'top': 0.489, 'left': 0.669, 'label': 'Perna Esquerda Superior'},
  {'top': 0.704, 'left': 0.332, 'label': 'Joelho Direito'},
  {'top': 0.704, 'left': 0.65, 'label': 'Joelho Esquerdo'},
  {'top': 0.909, 'left': 0.314, 'label': 'Pé Direito'},
  {'top': 0.909, 'left': 0.678, 'label': 'Pé Esquerdo'},
];

// Lista de opções para o tipo de dor (aguda, crônica, etc)
List<ExclusiveOptionItem> painLevelListItems = [
  ExclusiveOptionItem(
      title: 'Aguda', subtitle: 'Dor repentina instantânea e pontual.'),
  ExclusiveOptionItem(
      title: 'Crônica', subtitle: 'Dor recorrente e permanente.'),
  ExclusiveOptionItem(
      title: 'Não sinto mais dores!',
      subtitle: 'Essa dor não me incomoda mais.'),
];

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sensetal_presentation_design_app/theme/app_icons.dart';
import 'package:sensetal_presentation_design_app/theme/app_images.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/space_widgets.dart';

const String genderMaleDBName = 'Masculino';

class OnBodyPainSelectionWidget extends StatefulWidget {
  final String gender;
  const OnBodyPainSelectionWidget({super.key, required this.gender});

  @override
  State<OnBodyPainSelectionWidget> createState() =>
      _OnBodyPainSelectionWidgetState();
}

class _OnBodyPainSelectionWidgetState extends State<OnBodyPainSelectionWidget> {
  bool isFrontSide = true;
  List<Map<String, dynamic>> points = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SizedBox(
        child: Stack(
          children: [
            Center(
              child: imageSideSelector(widget.gender, isFrontSide),
            ),
            Positioned(
              left: 0,
              child: GestureDetector(
                onTap: () {
                  isFrontSide = !isFrontSide;
                  setState(() {});
                },
                child: SizedBox(
                  height: 40,
                  width: 80,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppIcons.systemSensetalIconClockwiseArrows,
                        width: 40,
                      ),
                      const HorizontalSpace(size: AppSpaceSize.xs),
                      const Text('Virar')
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

LayoutBuilder imageSideSelector(String gender, bool isFrontSide) {
  List<List<double>> maleImageJointsCoordinates = [
    // Aqui você pode definir as posições dos círculos para cada parte do corpo
    // Exemplo: [altura, lateralidade]
    [0.153, 0.5], // Pescoco
    [0.237, 0.5], // Peito
    [0.434, 0.5], // Barriga

    [0.208, 0.227], // Ombro Direito
    [0.208, 0.773], // Ombro Esquerdo
    [0.357, 0.153], // Cotuvelo Direito
    [0.357, 0.852], // Cotuvelo Esquerdo
    [0.49, 0.082], // Mao Direita
    [0.49, 0.923], // Mao Esquerda

    [0.473, 0.316], // Perna Direita Superior
    [0.473, 0.669], // Perna Esquerda Superior
    [0.694, 0.342], // Joelho Direito
    [0.694, 0.65], // Joelho Esquerdo
    [0.903, 0.323], // Pe Direito
    [0.903, 0.678], // Pe Esquerdo
  ];

  List<List<double>> femaleImageJointsCoordinates = [
    // Aqui você pode definir as posições dos círculos para cada parte do corpo
    // Exemplo: [altura, lateralidade]
    [0.175, 0.495], // Pescoco
    [0.258, 0.495], // Peito
    [0.45, 0.495], // Barriga

    [0.23, 0.212], // Ombro Direito
    [0.23, 0.775], // Ombro Esquerdo
    [0.375, 0.135], // Cotuvelo Direito
    [0.375, 0.858], // Cotuvelo Esquerdo
    [0.505, 0.064], // Mao Direita
    [0.505, 0.933], // Mao Esquerda

    [0.489, 0.305], // Perna Direita Superior
    [0.489, 0.669], // Perna Esquerda Superior
    [0.704, 0.332], // Joelho Direito
    [0.704, 0.65], // Joelho Esquerdo
    [0.909, 0.314], // Pe Direito
    [0.909, 0.678], // Pe Esquerdo
  ];

  return LayoutBuilder(builder: (context, constraints) {
    final bool isMale = gender == genderMaleDBName;
    final double maxImageWidth =
        isMale ? constraints.maxWidth * 0.42 : constraints.maxWidth * 0.4;
    final image = isMale
        ? (isFrontSide ? AppImages.maleModelFront : AppImages.maleModelBack)
        : (isFrontSide
            ? AppImages.femaleModelFront
            : AppImages.femaleModelBack);
    final clickAreaCoordinates =
        isMale ? maleImageJointsCoordinates : femaleImageJointsCoordinates;
    final double aspectRatio = isMale ? 3.195 : 3.375;
    final double imageWidth = maxImageWidth;
    final double imageHeight = imageWidth * aspectRatio;
    const double clickAreaDiameterSize = 20.0;

    return Center(
      child: SizedBox(
        width: imageWidth + clickAreaDiameterSize,
        height: imageHeight + 10,
        child: Stack(
          clipBehavior: Clip.none, // Permite overflow dos filhos
          children: [
            Positioned(
              left: clickAreaDiameterSize / 2,
              top: clickAreaDiameterSize / 2,
              child: SvgPicture.asset(
                image,
                width: imageWidth,
                height: imageHeight,
              ),
            ),
            ...clickAreaCoordinates.map(
              (pos) => Positioned(
                left: pos[1] * imageWidth,
                top: pos[0] * imageHeight,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: clickAreaDiameterSize,
                    height: clickAreaDiameterSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red.withOpacity(0.4),
                      border: Border.all(color: Colors.red, width: 2),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  });
}

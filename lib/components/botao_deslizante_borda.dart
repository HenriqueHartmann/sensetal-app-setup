import 'package:flutter/material.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';

class BorderedThumbShape extends SliderComponentShape {
  final double thumbRadius;
  final Color fillColor;
  final Color borderColor;
  final double borderWidth;
  final TextStyle textStyle;

  BorderedThumbShape(
      {this.thumbRadius = 14,
      this.fillColor = Colors.transparent,
      this.borderColor = AppColors.primary05,
      this.borderWidth = 2,
      this.textStyle = const TextStyle(
        fontSize: 12,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      )});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    // Círculo com a cor de fundo (preenchimento)
    final Paint fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill
      ..shader = AppColors.gradientMain.createShader(
          Rect.fromCircle(center: center, radius: thumbRadius / 4));

    canvas.drawCircle(center, thumbRadius, fillPaint);

    // Círculo da borda
    final Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    // Texto no centro do thumb
    final textSpan = TextSpan(
      text: (value * 10).round().toString(), // valor arredondado
      style: textStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: textDirection,
    );

    canvas.drawCircle(center, thumbRadius, borderPaint);
    textPainter.layout();
    final textOffset =
        center - Offset(textPainter.width / 2, textPainter.height / 2);
    textPainter.paint(canvas, textOffset);
  }

  static of(BuildContext context) {}
}

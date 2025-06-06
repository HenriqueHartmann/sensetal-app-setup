import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final TextStyle? textStyle;

  /// Cor ou degradê da barra
  final Color trackColor;
  final LinearGradient? trackGradient;

  /// Thumb
  final Color thumbColor;
  final LinearGradient? thumbGradient;
  final Color? thumbBorderColor;
  final double thumbBorderWidth;
  final double thumbRadius;
  final double trackHeight;

  const CustomSlider({
    super.key,
    required this.value,
    required this.onChanged,
    required this.min,
    required this.max,
    this.trackColor = Colors.grey,
    this.trackGradient,
    this.thumbColor = Colors.white,
    this.thumbGradient,
    this.thumbBorderColor,
    this.thumbBorderWidth = 2.0,
    this.thumbRadius = 10.0,
    this.trackHeight = 4.0,
    this.textStyle,
  });

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: widget.trackHeight,
        trackShape: _CustomSliderTrackShape(
          trackColor: widget.trackColor,
          gradient: widget.trackGradient,
          trackHeight: widget.trackHeight,
        ),
        thumbShape: _CustomSliderThumbShape(
          thumbRadius: widget.thumbRadius,
          thumbColor: widget.thumbColor,
          gradient: widget.thumbGradient,
          borderColor: widget.thumbBorderColor,
          borderWidth: widget.thumbBorderWidth,
          min: widget.min,
          max: widget.max,
          textStyle: widget.textStyle,
        ),
        thumbColor: Colors.transparent,
        // Configurações para ocultar as divisões, mas manter a funcionalidade
        tickMarkShape: SliderTickMarkShape.noTickMark,
        showValueIndicator: ShowValueIndicator.never,
        overlayShape: SliderComponentShape.noOverlay,
      ),
      child: Slider(
        value: widget.value,
        onChanged: widget.onChanged,
        min: widget.min,
        max: widget.max,
        divisions: (widget.max - widget.min).toInt(),
      ),
    );
  }
}

// ===== Barra personalizada =====
class _CustomSliderTrackShape extends SliderTrackShape {
  final Color trackColor;
  final LinearGradient? gradient;
  final double trackHeight;

  _CustomSliderTrackShape({
    required this.trackColor,
    this.gradient,
    this.trackHeight = 4.0,
  });

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    // Default horizontal padding for the track
    const double horizontalPadding = 8.0;
    final double trackLeft = offset.dx + horizontalPadding;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width - 2 * horizontalPadding;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    Offset? secondaryOffset,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    bool isDiscrete = false,
    bool isEnabled = false,
  }) {
    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
    );

    final Paint paint = Paint()
      ..color = trackColor
      ..shader = gradient?.createShader(trackRect);

    context.canvas.drawRRect(
      RRect.fromRectAndRadius(trackRect, Radius.circular(trackHeight / 2)),
      paint,
    );
  }
}

// ===== Thumb personalizado =====
class _CustomSliderThumbShape extends SliderComponentShape {
  final double thumbRadius;
  final Color thumbColor;
  final LinearGradient? gradient;
  final Color? borderColor;
  final double borderWidth;
  final double min;
  final double max;
  final TextStyle? textStyle;

  _CustomSliderThumbShape({
    this.thumbRadius = 10.0,
    required this.thumbColor,
    this.gradient,
    this.borderColor,
    this.borderWidth = 2.0,
    this.min = 0.0,
    this.max = 1.0,
    this.textStyle,
  });

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

    // Desenha o círculo do thumb
    final Rect thumbRect = Rect.fromCircle(center: center, radius: thumbRadius);
    final Paint paint = Paint()
      ..color = thumbColor
      ..shader = gradient?.createShader(thumbRect);

    canvas.drawCircle(center, thumbRadius, paint);

    // Desenha a borda se especificada
    if (borderColor != null && borderWidth > 0) {
      final Paint borderPaint = Paint()
        ..color = borderColor!
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth;
      canvas.drawCircle(center, thumbRadius, borderPaint);
    }

    // Calcula o valor real baseado no min e max
    final double realValue = min + (value * (max - min));
    final String valueText = realValue.round().toString();

    final TextSpan textSpan = TextSpan(
      text: valueText,
      style: textStyle ??
          TextStyle(
            color: Colors.white,
            fontSize: thumbRadius * 0.8,
            fontWeight: FontWeight.bold,
          ),
    );

    final TextPainter textPainter = TextPainter(
      text: textSpan,
      textDirection: textDirection,
      textAlign: TextAlign.center,
    );

    textPainter.layout();

    // Centraliza o texto no thumb
    final Offset textOffset = Offset(
      center.dx - textPainter.width / 2,
      center.dy - textPainter.height / 2,
    );

    textPainter.paint(canvas, textOffset);
  }
}

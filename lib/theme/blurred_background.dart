import 'package:flutter/material.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';

class TopLeftBlurredBackgroundPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    Paint primarypaint = Paint()
    ..strokeWidth = 2
    ..color = AppColors.primary02.withOpacity(0.3)
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 40);

    Paint secondarypaint = Paint()
    ..strokeWidth = 2
    ..color = AppColors.success02.withOpacity(0.3)
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 45);

    Paint tertiaryPaint = Paint()
    ..strokeWidth = 2
    ..color = AppColors.secondary02.withOpacity(0.3)
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 40);
    
    Paint quaternaryPaint = Paint()
    ..strokeWidth = 2
    ..color = AppColors.neutralContrast.withOpacity(0.3)
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 40);

    canvas.drawCircle(
      Offset(size.width / 20, size.height / 60), 
      size.width * 0.1, 
      quaternaryPaint
    );
    canvas.drawCircle(
      Offset(size.width / 10, size.height / 7.5), 
      size.width * 0.15, 
      primarypaint
    );
    canvas.drawCircle(
      Offset(size.width / 3.5, size.height / 32), 
      size.width * 0.13, 
      secondarypaint
    );
    canvas.drawCircle(
      Offset(size.width / 6, size.height / 5), 
      size.width * 0.13, 
      tertiaryPaint
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class BottomRightBlurredBackgroundPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    Paint primarypaint = Paint()
    ..strokeWidth = 2
    ..color = AppColors.primary02.withOpacity(0.5)
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 45);

    Paint secondarypaint = Paint()
    ..strokeWidth = 2
    ..color = AppColors.success02.withOpacity(0.5)
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 45);

    Paint tertiaryPaint = Paint()
    ..strokeWidth = 2
    ..color = AppColors.secondary02.withOpacity(0.5)
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 40);
    
    Paint quaternaryPaint = Paint()
    ..strokeWidth = 2
    ..color = AppColors.neutralContrast.withOpacity(0.5)
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 40);

    canvas.drawCircle(
      Offset(size.width / 1.7, size.height / 1.25), 
      size.width * 0.1, 
      quaternaryPaint
    );
    canvas.drawCircle(
      Offset(size.width / 1.7, size.height / 1.08), 
      size.width * 0.15, 
      primarypaint
    );
    canvas.drawCircle(
      Offset(size.width / 1.15, size.height / 1.2), 
      size.width * 0.13, 
      secondarypaint
    );
    canvas.drawCircle(
      Offset(size.width / 1.2, size.height / 1.04), 
      size.width * 0.13, 
      tertiaryPaint
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class BlurredBackground extends StatelessWidget {
  final Widget child;

  const BlurredBackground({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: TopLeftBlurredBackgroundPainter(),
          ),
        ),
        Positioned.fill(
          child: CustomPaint(
            painter: BottomRightBlurredBackgroundPainter(),
          ),
        ),

        child,
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sensetal_presentation_design_app/theme/app_icons.dart';
import 'package:sensetal_presentation_design_app/theme/blurred_background.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageLoading extends StatefulWidget {
  const PageLoading({super.key});

  @override
  State<PageLoading> createState() => _PageLoadingState();
}

class _PageLoadingState extends State<PageLoading>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _rotation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _rotation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _startLoop();
  }

  Future<void> _startLoop() async {
    while (mounted) {
      await _controller.forward(from: 0.0);
      await Future.delayed(const Duration(seconds: 1, milliseconds: 500));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlurredBackground(
          child: Center(
            child: LayoutBuilder(builder: (context, constraints) {
              double iconWidth = constraints.maxWidth * 0.32;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AnimatedBuilder(
                    animation: _rotation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _rotation.value *
                            2 *
                            3.1415926535, // 0 to 2π (360°)
                        child: child,
                      );
                    },
                    child: SvgPicture.asset(
                      AppIcons.sensetalIcon,
                      width: iconWidth,
                      semanticsLabel: 'Sensetal icon',
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

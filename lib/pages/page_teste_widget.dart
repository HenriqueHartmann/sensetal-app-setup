import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sensetal_presentation_design_app/components/last_pain_measure_widget.dart';
import 'package:sensetal_presentation_design_app/components/last_five_pain_measure_widget.dart';
import 'package:sensetal_presentation_design_app/components/imc_widget.dart';
import 'package:sensetal_presentation_design_app/components/exercise_streak_widget.dart';
import 'package:sensetal_presentation_design_app/components/custom_slider.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';
import 'package:sensetal_presentation_design_app/theme/app_icons.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/blurred_background.dart';
import 'package:sensetal_presentation_design_app/utils/helper_widgets/space_widgets.dart';

const List<double> lastFivePainMeasure = [1.0, 4.0, 2.0, .0, 5.0];
DateTime lastPainMeasureDate = DateTime.now();
const List<double> lastThreeDaysExecution = [1, 1, 0];

List<DateTime> lastFiveMeasureDays = [
  DateTime(2001, 01, 01),
  DateTime(2002, 02, 02),
  DateTime(2003, 03, 03),
  DateTime(2004, 04, 04),
  DateTime(2005, 05, 05),
];

const String painAreaName = 'Lombar';

const String painScale = "Aguda";

const double valorImc = 20.37;
const String classificacaoImc = "Normal";
const String subTxtClassificacaoImc = "Entre 18.5 e 24.9";
const String gender = "Masculino";

class PageTeste extends StatefulWidget {
  const PageTeste({super.key});

  @override
  State<PageTeste> createState() => _PageTesteState();
}

class _PageTesteState extends State<PageTeste> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlurredBackground(
          //showSensetalIcon: true,
          child: Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  double screenWidth = constraints.maxWidth;
                  double screenHeight = constraints.maxHeight;

                  double logoWidth = screenWidth * 0.43;
                  double verticalGap = screenHeight > 800
                      ? 130.0
                      : screenHeight > 600
                          ? screenHeight * 0.17
                          : screenHeight * 0.12;
                  double horizontalPadding = screenWidth < 400
                      ? getSizeFromEnum(AppSpaceSize.md)
                      : screenWidth < 800
                          ? getSizeFromEnum(AppSpaceSize.xl)
                          : getSizeFromEnum(AppSpaceSize.custom, 64.0);

                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: getSizeFromEnum(AppSpaceSize.custom, 64.0),
                        bottom: getSizeFromEnum(AppSpaceSize.xl),
                        left: horizontalPadding,
                        right: horizontalPadding,
                      ),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              SvgPicture.asset(
                                AppIcons.brandSensetalLogo,
                                width: logoWidth,
                                semanticsLabel: 'Sensetal logo',
                              )
                            ],
                          ),
                          VerticalSpace(
                              size: AppSpaceSize.custom, custom: verticalGap),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const ImcIndicatorWidget(
                                  imcValue: valorImc,
                                  imcCategory: classificacaoImc,
                                  subTextImcCategory: subTxtClassificacaoImc,
                                  gender: gender),
                              const VerticalSpace(size: AppSpaceSize.md),
                              CustomSlider(
                                min: 0,
                                max: 10,
                                activeTrackGradient: AppColors.gradientMain,
                                thumbGradient: AppColors.gradientMain,
                                thumbBorderColor: const Color(0xFF5C5C5C),
                                thumbBorderWidth: 4,
                                thumbRadius: 12,
                                trackHeight: 8,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(),
                              ),
                              const VerticalSpace(size: AppSpaceSize.md),
                              LastPainMeasureWidget(
                                  data: LastPainMeasureData(
                                      lastFivePainMeasure: lastFivePainMeasure,
                                      painScale: painScale,
                                      lastPainMeasureDate:
                                          lastPainMeasureDate)),
                              const VerticalSpace(size: AppSpaceSize.md),
                              LastFivePainMeasureWidget(
                                  painAreaName: painAreaName,
                                  lastFivePainMeasure: lastFivePainMeasure,
                                  lastFivePainMeasureDate: lastFiveMeasureDays),
                              const VerticalSpace(size: AppSpaceSize.md),
                              const ExerciseStreakWidget(
                                lastThreeDaysExecution: lastThreeDaysExecution,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

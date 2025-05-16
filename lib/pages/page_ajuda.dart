import 'package:flutter/material.dart';
import 'package:sensetal_presentation_design_app/theme/app_border_radius.dart';
import 'package:sensetal_presentation_design_app/theme/app_colors.dart';
import 'package:sensetal_presentation_design_app/theme/app_space_size.dart';

class PageAjuda extends StatefulWidget {
  const PageAjuda({super.key});

  @override
  State<PageAjuda> createState() => _PageAjudaState();
}

class _PageAjudaState extends State<PageAjuda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                double screenWidth = constraints.maxWidth;
                double screenHeight = constraints.maxHeight;

                double logoWidth = screenWidth / 3;
                double verticalGap = screenHeight > 800
                    ? 150.0
                    : screenHeight > 600
                        ? screenHeight * 0.2
                        : screenHeight * 0.14;
                double horizontalPadding = screenWidth < 500
                    ? getSizeFromEnum(AppSpaceSize.md)
                    : screenWidth < 800
                        ? getSizeFromEnum(AppSpaceSize.xl)
                        : getSizeFromEnum(AppSpaceSize.custom, 64.0);

                return Stack(
                  children: [
                    // Background topo
                    Image.asset(
                      'assets/images/bg_treino_ajuda.png',
                      fit: BoxFit.cover,
                      width: screenWidth,
                    ),
                    Container(
                        margin: EdgeInsets.only(
                          top: 240,
                        ),
                        padding: EdgeInsets.only(
                          top: getSizeFromEnum(AppSpaceSize.lg),
                          right: getSizeFromEnum(AppSpaceSize.md),
                          left: getSizeFromEnum(AppSpaceSize.md),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          color: AppColors.neutralWhite,
                        ),
                        width: screenWidth,
                        height: double.infinity,
                        child: ListView(
                          children: [
                            Text(
                              "Precisa de ajuda?",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(color: AppColors.neutral01),
                            ),
                            SizedBox(height: getSizeFromEnum(AppSpaceSize.lg)),
                            Container(
                              padding: EdgeInsets.all(
                                  getSizeFromEnum(AppSpaceSize.md)),
                              decoration: const BoxDecoration(
                                color: AppColors.primary05,
                                borderRadius: AppBorderRadius.md,
                              ),
                              height: 94,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.square_rounded, size: 32),
                                      Text("FAQ")
                                    ],
                                  ),
                                  Text(
                                      "Confira as respostas para as perguntas frequentes")
                                ],
                              ),
                            ),
                            SizedBox(height: getSizeFromEnum(AppSpaceSize.lg)),
                            Container(
                              padding: EdgeInsets.all(
                                  getSizeFromEnum(AppSpaceSize.md)),
                              decoration: const BoxDecoration(
                                color: AppColors.primary05,
                                borderRadius: AppBorderRadius.md,
                              ),
                              height: 94,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.square_rounded, size: 32),
                                      Text("Chat")
                                    ],
                                  ),
                                  Text("Estamos aqui para te ouvir")
                                ],
                              ),
                            ),
                            SizedBox(height: getSizeFromEnum(AppSpaceSize.lg)),
                            Container(
                              padding: EdgeInsets.all(
                                  getSizeFromEnum(AppSpaceSize.md)),
                              decoration: const BoxDecoration(
                                color: AppColors.primary05,
                                borderRadius: AppBorderRadius.md,
                              ),
                              height: 96,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.square_rounded, size: 32),
                                      Text("sensetalapp")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.square_rounded, size: 32),
                                      Text("contato@sensetal.com.br")
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: getSizeFromEnum(AppSpaceSize.lg)),
                            Text("Segurança e Transparência",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(color: AppColors.neutral01)),
                            SizedBox(height: getSizeFromEnum(AppSpaceSize.lg)),
                            Container(
                              padding: EdgeInsets.all(
                                  getSizeFromEnum(AppSpaceSize.md)),
                              decoration: const BoxDecoration(
                                color: AppColors.primary05,
                                borderRadius: AppBorderRadius.md,
                              ),
                              height: 64,
                              child: Row(
                                children: [
                                  Icon(Icons.square_rounded, size: 32),
                                  Text("sensetalapp")
                                ],
                              ),
                            ),
                            SizedBox(height: getSizeFromEnum(AppSpaceSize.lg)),
                            Container(
                              padding: EdgeInsets.all(
                                  getSizeFromEnum(AppSpaceSize.md)),
                              decoration: const BoxDecoration(
                                color: AppColors.primary05,
                                borderRadius: AppBorderRadius.md,
                              ),
                              height: 64,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.square_rounded, size: 32),
                                      Text("sensetalapp")
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

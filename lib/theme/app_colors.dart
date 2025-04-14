import 'package:flutter/material.dart';

class AppColors {
  // 1. Brand Colors
  static const Color primary01 = Color.fromRGBO(15, 45, 64, 1);
  static const Color primary02 = Color.fromRGBO(25, 75, 108, 1);
  static const Color primary03 = Color.fromRGBO(95, 129, 158, 1);
  static const Color primary04 = Color.fromRGBO(207, 222, 229, 1);
  static const Color primary05 = Color.fromRGBO(240, 243, 247, 1);

  static const Color secondary01 = Color.fromRGBO(167, 176, 95, 1);
  static const Color secondary02 = Color.fromRGBO(224, 234, 138, 1);
  static const Color secondary03 = Color.fromRGBO(248, 255, 186, 1);
  static const Color secondary04 = Color.fromRGBO(251, 255, 215, 1);
  static const Color secondary05 = Color.fromRGBO(254, 255, 245, 1);

  // 2. Neutral Colors
  static const Color neutral01 = Color.fromRGBO(23, 24, 25, 1);
  static const Color neutral02 = Color.fromRGBO(41, 46, 51, 1);
  static const Color neutral03 = Color.fromRGBO(71, 87, 102, 1);
  static const Color neutral04 = Color.fromRGBO(143, 161, 178, 1);
  static const Color neutral05 = Color.fromRGBO(223, 236, 247, 1);
  static const Color neutralWhite = Color.fromRGBO(255, 255, 255, 1);
  static const Color neutralContrast = Color.fromRGBO(239, 239, 239, 1);

  // 3. Feedback Colors
  static const Color success01 = Color.fromRGBO(0, 107, 95, 1);
  static const Color success02 = Color.fromRGBO(0, 148, 131, 1);
  static const Color success03 = Color.fromRGBO(109, 255, 238, 1);
  static const Color success04 = Color.fromRGBO(173, 255, 245, 1);
  static const Color success05 = Color.fromRGBO(237, 255, 253, 1);

  static const Color info01 = Color.fromRGBO(8, 41, 88, 1);
  static const Color info02 = Color.fromRGBO(0, 85, 204, 1);
  static const Color info03 = Color.fromRGBO(109, 170, 255, 1);
  static const Color info04 = Color.fromRGBO(173, 207, 255, 1);
  static const Color info05 = Color.fromRGBO(237, 244, 255, 1);

  static const Color warning01 = Color.fromRGBO(107, 57, 0, 1);
  static const Color warning02 = Color.fromRGBO(204, 109, 0, 1);
  static const Color warning03 = Color.fromRGBO(255, 187, 199, 1);
  static const Color warning04 = Color.fromRGBO(255, 217, 173, 1);
  static const Color warning05 = Color.fromRGBO(255, 247, 237, 1);

  static const Color error01 = Color.fromRGBO(107, 0, 9, 1);
  static const Color error02 = Color.fromRGBO(148, 0, 12, 1);
  static const Color error03 = Color.fromRGBO(255, 109, 121, 1);
  static const Color error04 = Color.fromRGBO(255, 173, 180, 1);
  static const Color error05 = Color.fromRGBO(255, 237, 238, 1);

  static const LinearGradient gradientMain = LinearGradient(
    colors: [
      primary02,
      success02,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

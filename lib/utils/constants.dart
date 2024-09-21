import 'package:flutter/material.dart';

double sizeh(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double sizew(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

const customGradient = LinearGradient(
  colors: [
    Color(0xFF4C8479),
    Color(0xFF2B5F56),
  ],
  begin: Alignment(1.0, -0.29),
  end: Alignment(-1.0, 0.98),
);

const customGradient2 = LinearGradient(
  colors: [
    Color(0xFF4C8479),
    Color(0xFF2B5F56),
  ],
  begin: Alignment(-0.58, -0.81),
  end: Alignment(0.58, 0.81),
);

const buttonGradient = LinearGradient(
  colors: [
    Color(0xFF4C8479),
    Color(0xFF2B5F56),
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

class AppTheme {
  static bool isDarkMode = true;

  static const Color primaryColor = Color(0xff2B524A);
  static const Color secondaryColor = Color(0xff758f89);

  static const TextStyle headingTextStyle = TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      letterSpacing: 2);

  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w900,
    color: secondaryColor,
  );

  static const TextStyle title2TextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w900,
    color: Colors.black,
  );

  static TextStyle hintTextStyle(BuildContext context) {
    return TextStyle(
        fontSize: sizew(context) * 0.04,
        fontWeight: FontWeight.w500,
        color: AppTheme.secondaryColor);
  }

  static const TextStyle subtitle2TextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  static const TextStyle subtitle3TextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Color(0xff121B17),
  );
}

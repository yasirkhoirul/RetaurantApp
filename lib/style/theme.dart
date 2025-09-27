import 'package:flutter/material.dart';
import 'package:restaurant_app/style/sizetext.dart';

class TurisTheme {
  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: Textstyle.displayLarge,
      displayMedium: Textstyle.displayMedium,
      displaySmall: Textstyle.displaySmall,
      headlineLarge: Textstyle.headlineLarge,
      headlineMedium: Textstyle.headlineMedium,
      headlineSmall: Textstyle.headlineSmall,
      titleLarge: Textstyle.titleLarge,
      titleMedium: Textstyle.titleMedium,
      titleSmall: Textstyle.titleSmall,
      bodyLarge: Textstyle.bodyLargeBold,
      bodyMedium: Textstyle.bodyLargeMedium,
      bodySmall: Textstyle.bodyLargeRegular,
      labelLarge: Textstyle.labelLarge,
      labelMedium: Textstyle.labelMedium,
      labelSmall: Textstyle.labelSmall,
    );
  }

  static AppBarTheme get _appBarTheme {
    return AppBarTheme(
      toolbarTextStyle: _textTheme.titleLarge,
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        ),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      colorSchemeSeed: Colors.blue,
      brightness: Brightness.light,
      textTheme: _textTheme,
      useMaterial3: true,
      appBarTheme: _appBarTheme,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorSchemeSeed: Colors.blue,
      brightness: Brightness.dark,
      textTheme: _textTheme,
      useMaterial3: true,
      appBarTheme: _appBarTheme,
    );
  }
}

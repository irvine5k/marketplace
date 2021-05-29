import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme => ThemeData(
        scaffoldBackgroundColor: AppColors.white,
        primaryColor: AppColors.purple,
        accentColor: AppColors.white.withOpacity(0.8),
        textTheme: TextTheme(
          button: TextStyle(color: AppColors.black),
          headline5: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
          headline6: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
          bodyText2: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
          bodyText1: TextStyle(
            color: AppColors.black.withOpacity(0.6),
            fontWeight: FontWeight.w400,
          ),
        ),
        elevatedButtonTheme:
            ElevatedButtonThemeData(style: elevatedButtonTheme()),
        iconTheme: const IconThemeData(color: AppColors.black),
        appBarTheme: const AppBarTheme(
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: AppColors.black),
          textTheme: TextTheme(
            headline6: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );

  static ButtonStyle elevatedButtonTheme() {
    return ButtonStyle(
      animationDuration: const Duration(milliseconds: 0),
      elevation: MaterialStateProperty.all<double>(0.0),
      backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.disabled)) {
          return AppColors.grey;
        }

        return AppColors.purple;
      }),
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(
          color: Colors.white,
        ),
      ),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
      ),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 32,
        ),
      ),
    );
  }
}

class AppColors {
  static const purple = Color(0xff6c1aaa);
  static const grey = Color(0xffe3e4e8);
  static const white = Color(0xffffffff);
  static const black = Color(0xff000000);
}

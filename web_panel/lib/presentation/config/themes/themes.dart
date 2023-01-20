import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_panel/presentation/config/colors/colors.dart';

class AppThemes {
  static final light = ThemeData(
    colorScheme: ColorScheme.light(
      primary: AppColors.mediumRed,
      secondary: AppColors.lighterRed,
    ),
    scaffoldBackgroundColor: AppColors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: AppColors.mediumRed,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightGrey,
    ),
    textTheme: TextTheme(
      headline1: GoogleFonts.poppins(
        fontSize: 105,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
      ),
      headline2: GoogleFonts.poppins(
        fontSize: 65,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
      ),
      headline3: GoogleFonts.poppins(
        fontSize: 52,
        fontWeight: FontWeight.w400,
      ),
      headline4: GoogleFonts.poppins(
        fontSize: 37,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      headline5: GoogleFonts.poppins(
        fontSize: 26,
        fontWeight: FontWeight.w400,
      ),
      headline6: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      subtitle1: GoogleFonts.poppins(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
      ),
      subtitle2: GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      bodyText1: GoogleFonts.poppins(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
      bodyText2: GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      button: GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
      ),
      caption: GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
      overline: GoogleFonts.poppins(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
      ),
    ),
    cardColor: AppColors.lightGrey,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.mediumRed),
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(3)),
          ),
        ),
      ),
    ),
  );
}

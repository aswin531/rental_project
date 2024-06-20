import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentit/core/constants/colors.dart';

class CustomTextStyles {
  static TextStyle get headline1 {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: primary,
      ),
    );
  }

  static TextStyle get headline2 {
    return GoogleFonts.roboto(
      textStyle: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    );
  }

  static TextStyle get headline3 {
    return GoogleFonts.lato(
      textStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    );
  }

  static TextStyle get bodyText1 {
    return GoogleFonts.openSans(
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
    );
  }

  static TextStyle get bodyText2 {
    return GoogleFonts.openSans(
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
    );
  }

  static TextStyle get caption {
    return GoogleFonts.openSans(
      textStyle: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: primary,
      ),
    );
  }

  static TextStyle get captiongrey {
    return GoogleFonts.openSans(
      textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: greydark,
      ),
    );
  }

  static TextStyle get mobilescreentext {
    return GoogleFonts.openSans(
      textStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: greydark,
      ),
    );
  }

  static TextStyle get landingtext {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: primary,
      ),
    );
  }

  static TextStyle get buttonlabeltext {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: white,
      ),
    );
  }

  // Add more custom text styles as needed
}

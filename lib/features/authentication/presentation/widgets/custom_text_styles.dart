import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentit/core/constants/colors.dart';

class CustomTextStyles {
  static TextStyle get headline1 {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        color: primary,
      ),
    );
  }

  static TextStyle get headline2 {
    return GoogleFonts.roboto(
      textStyle:  TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    );
  }

  static TextStyle get headline3 {
    return GoogleFonts.lato(
      textStyle:  TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    );
  }

  static TextStyle get bodyText1 {
    return GoogleFonts.openSans(
      textStyle:  TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
    );
  }

  static TextStyle get bodyText2 {
    return GoogleFonts.openSans(
      textStyle:  TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
    );
  }

  static TextStyle get caption {
    return GoogleFonts.openSans(
      textStyle: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w700,
        color: primary,
      ),
    );
  }

  static TextStyle get captiongrey {
    return GoogleFonts.openSans(
      textStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: greydark,
      ),
    );
  }

  static TextStyle get mobilescreentext {
    return GoogleFonts.openSans(
      textStyle: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: greydark,
      ),
    );
  }

  static TextStyle get landingtext {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
        color: primary,
      ),
    );
  }

  static TextStyle get buttonlabeltext {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: white,
      ),
    );
  }
  static TextStyle get nonbuttonlabeltext {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: primary,
      ),
    );
  }
  // Add more custom text styles as needed
}

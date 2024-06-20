import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentit/core/constants/colors.dart';

class CustomProfileTextStyles {
  // Main heading style for the profile section
  static TextStyle get mainHeading => TextStyle(
        fontSize: 24.0.sp, // Font size for the main heading
        fontWeight: FontWeight.bold, // Font weight for emphasis
        color: Colors.black, // Color of the text
      );

  // Style for the name in the profile
  static TextStyle get nameStyle => TextStyle(
        fontSize: 20.0.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      );

  // Style for other information like bio or description
  static TextStyle get bioStyle => TextStyle(
        fontSize: 16.0.sp,
        fontWeight: FontWeight.normal,
        color: Colors.grey[700], // A bit lighter color
      );

  static TextStyle get bioprofStyle => TextStyle(
        fontSize: 16.0.sp,
        fontWeight: FontWeight.normal,
        color: black, // A bit lighter color
      );

  // Style for secondary information, like labels
  static TextStyle get labelStyle => TextStyle(
        fontSize: 14.0.sp,
        fontWeight: FontWeight.w300,
        color: Colors.grey[600],
      );
}

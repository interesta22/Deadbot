import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const String apiKey = 'AIzaSyAgIfzDZCpfPQ8mxQvqWoTnd2nOFw3YeQg';

class MyFonts {
  static TextStyle get welcomefont1 => GoogleFonts.fredoka(
      color: const Color(0xff1E1E1E), fontSize: 55, fontWeight: FontWeight.w600);
  static TextStyle get welcomefont2 => GoogleFonts.fredoka(
      color: const Color(0xffffffff), fontSize: 55, fontWeight: FontWeight.w600);

  static TextStyle get font22black =>
      GoogleFonts.fredoka(color: Colors.grey.shade900, fontSize: 19,fontWeight: FontWeight.w500);

  static TextStyle get font30black => GoogleFonts.fredoka(
      color: Colors.deepPurple, fontSize: 40, fontWeight: FontWeight.w600);

  static TextStyle get font22white => GoogleFonts.fredoka(
      color: const Color(0xffffffff), fontSize: 19, fontWeight: FontWeight.w500);
  
  static TextStyle get font13grey => GoogleFonts.fredoka(
      color: Colors.grey.shade500,fontSize: 13,);

  static TextStyle get font15grey => GoogleFonts.poppins(
        color: Colors.grey.shade500,
        fontSize: 15,
        fontWeight: FontWeight.w400
      );

  static TextStyle get font13black => GoogleFonts.fredoka(color: const Color(0xff272727),fontSize: 17);
  static TextStyle get font13blackbold => GoogleFonts.fredoka(color: Colors.black,fontSize: 16,fontWeight:FontWeight.w500);
  static TextStyle get buttonwhite => GoogleFonts.fredoka(
      color: const Color(0xffffffff), fontSize: 19, fontWeight: FontWeight.w500);
}

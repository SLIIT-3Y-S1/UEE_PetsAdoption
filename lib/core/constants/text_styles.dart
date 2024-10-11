import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class TextStyles {
  static final TextStyle headlineLarge = GoogleFonts.fredoka(
    textStyle: const TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.w500,
    ),
  );
  static final TextStyle headlineMedium = GoogleFonts.fredoka(
    textStyle: const TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.normal,
    ),
  );

static final TextStyle labelLarge = GoogleFonts.fredoka(
    textStyle: const TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.normal
    ),
  );

  static final TextStyle labelMedium = GoogleFonts.fredoka(
    textStyle: const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w100
    ),
  );
  static final TextStyle labelSmall = GoogleFonts.fredoka(
    textStyle: const TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w100,
    ),
  );
  
  static final TextStyle bodySmall = GoogleFonts.fredoka(
    textStyle: const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
    ),
  );

    static final TextStyle bodyMedium = GoogleFonts.fredoka(
    textStyle: const TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.normal,
    ),
  );
}
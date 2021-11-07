import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// COLORS
import './colors.dart';

ThemeData lightThemeData = ThemeData.light().copyWith(
    textTheme: lightTextTheme,
    primaryColor: primaryColor,
    iconTheme: const IconThemeData(color: Colors.black54));

TextTheme lightTextTheme = ThemeData.light().textTheme.copyWith(
      headline1: ThemeData.light().textTheme.headline1!.merge(
            GoogleFonts.fredokaOne(
                color: Colors.black87,
                letterSpacing: .5,
                fontSize: 45,
                fontWeight: FontWeight.w500),
          ),
      headline2: ThemeData.light().textTheme.headline2!.merge(
            GoogleFonts.fredokaOne(
              color: Colors.black87,
              letterSpacing: .5,
              fontSize: 17,
              fontWeight: FontWeight.w200,
            ),
          ),
      headline3: ThemeData.light().textTheme.headline3!.merge(
            GoogleFonts.aBeeZee(
              color: Colors.black87,
              letterSpacing: .5,
              fontSize: 17,
              fontWeight: FontWeight.w200,
            ),
          ),
      headline4: ThemeData.light().textTheme.headline4!.merge(
            GoogleFonts.aBeeZee(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.normal,
            ),
          ),
      bodyText1: ThemeData.light().textTheme.bodyText1!.merge(
            GoogleFonts.aBeeZee(
              color: Colors.black54,
              letterSpacing: .5,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
      bodyText2:
          ThemeData.light().textTheme.bodyText2!.merge(GoogleFonts.aBeeZee(
                textStyle: const TextStyle(
                    color: Colors.black45,
                    letterSpacing: .5,
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              )),
    );

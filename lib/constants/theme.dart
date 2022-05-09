import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//The theme of the app is predefined so that it mantains the stability of the text and reduce repeatations
class ThemeClass {
  static ThemeData buildTheme(BuildContext context) {
    ThemeData themeData = ThemeData(
      primaryColor: const Color(0xFFEA4235),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
        color: Color(0xFFEA4235),
        iconTheme: IconThemeData(color: Colors.white),
        actionsIconTheme: IconThemeData(color: Colors.grey),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        elevation: 0.0,
        color: Color(0xFFEA4235),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFEA4235)),
      cupertinoOverrideTheme:
          const CupertinoThemeData(brightness: Brightness.light),
      primaryTextTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme)
          .copyWith(
              headline1: GoogleFonts.roboto(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  fontSize: 50),
              headline2: GoogleFonts.roboto(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  fontSize: 36),
              headline3: GoogleFonts.roboto(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 24,
                  fontStyle: FontStyle.normal),
              headline4: GoogleFonts.roboto(
                  color: Color(0xFFDB3224),
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  fontSize: 27),
              headline5: GoogleFonts.roboto(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  fontSize: 20),
              headline6: GoogleFonts.nunitoSans(
                  color: Color(0xFFDB3224),
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  fontSize: 18),
              subtitle1: GoogleFonts.roboto(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                  fontSize: 14),
              subtitle2: GoogleFonts.roboto(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
                fontSize: 15,
              ),
              caption: GoogleFonts.nunitoSans(
                  color: const Color(0xffFFFFFF),
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                  letterSpacing: -0.32),
              overline: GoogleFonts.nunitoSans(
                color: const Color(0xffFFFFFF),
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
              ),
              button: GoogleFonts.nunitoSans(
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  letterSpacing: 1.25)),
      buttonTheme: ButtonThemeData(
        buttonColor: const Color(0xFFEA4235),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
    return themeData;
  }
}

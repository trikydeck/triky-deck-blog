import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  final BuildContext _context;
  final VisualDensity _density = VisualDensity.adaptivePlatformDensity;
  final _dividerThemeData = DividerThemeData(endIndent: 10, indent: 10);

  MyTheme(this._context);

  final _black = Colors.grey[900];
  final _white = Colors.white;

  ThemeData get light {
    TextTheme textTheme = Theme.of(_context).textTheme.apply(
          bodyColor: _black,
          displayColor: _black,
          decorationColor: _black,
        );
    return ThemeData.light().copyWith(
      visualDensity: _density,
      primaryColor: _white,
      backgroundColor: _black,
      accentColor: Colors.deepOrange,
      textTheme: GoogleFonts.openSansTextTheme(textTheme),
      dividerTheme: _dividerThemeData,
      appBarTheme: AppBarTheme(
        color: _white,
        elevation: 0,
        iconTheme: IconThemeData(color: _black),
        textTheme: textTheme,
      ),
      scaffoldBackgroundColor: _white,
      iconTheme: IconThemeData(color: _black),
      inputDecorationTheme: InputDecorationTheme(
        alignLabelWithHint: false,
        filled: true,
        errorMaxLines: 1,
        fillColor: Colors.grey[200],
        border: InputBorder.none,
        errorBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent[700])),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        isCollapsed: false,
        labelStyle: TextStyle(color: Colors.grey[700]),
      ),
    );
  }

  ThemeData get dark {
    TextTheme textTheme = Theme.of(_context).textTheme.apply(
          displayColor: _white,
          bodyColor: _white,
          decorationColor: _white,
        );
    return ThemeData.dark().copyWith(
      visualDensity: _density,
      primaryColor: _black,
      backgroundColor: _white,
      textTheme: GoogleFonts.openSansTextTheme(textTheme),
      dividerTheme: _dividerThemeData,
      appBarTheme: AppBarTheme(elevation: 0),
      iconTheme: IconThemeData(color: _white),
      scaffoldBackgroundColor: _black,
      primaryColorDark: _black,
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(foregroundColor: _white),
      inputDecorationTheme: InputDecorationTheme(
        alignLabelWithHint: false,
        filled: true,
        errorMaxLines: 1,
        fillColor: Colors.grey[800],
        border: InputBorder.none,
        errorBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: _white)),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        isCollapsed: false,
      ),
    );
  }
}

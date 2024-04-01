import 'package:flutter/material.dart';


class MyThemes {
  static ThemeData lightTheme() {
    return ThemeData(
        primaryColor: const Color(0xffFF00FF),
        // primaryColorLight: const Color(0xff9BABB8),
        // primaryColorDark: const Color(0xffB83B5E),
        // disabledColor: const Color(0xff888888),
        // highlightColor: const Color(0xffF9ED69),
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Colors.white,
            onPrimary: Color(0xff9BABB8),
            secondary: Color(0xffB83B5E),
            onSecondary: Color(0xffB83B6F),
            error: Color(0xffB83B5E),
            onError: Color(0xffB83B5E),
            background: Color(0xff1a1817),
            onBackground: Color(0xffE1D4BB),
            surface: Color(0xffF5F0BB),
            onSurface: Color(0xffDBDFAA)));
       
  }
}

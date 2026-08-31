

import 'package:flutter/material.dart';

ThemeData lightmode = ThemeData(

  primaryColor: Colors.white ,   // titles and icons's color

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.red[600]
  ),

  colorScheme: ColorScheme(
    brightness: .light , 
    primary: Colors.white ,
    inversePrimary: Colors.black, 
    onPrimary: const Color(0xFFFF0000), 
    secondary: Color(0xFFFAFAFA), 
    onSecondary: Color(0xFFFAFAFA), 
    error: Colors.red, 
    onError: Colors.red, 
    surface: const Color(0xFFD32F2F), 
    inverseSurface: const Color(0xFFF49292),
    onSurface: const Color(0xFFD32F2F) ,
  ),
  
);




import 'package:flutter/material.dart';

ThemeData lightmode = ThemeData(

  primaryColor: Colors.white ,   // titles and icons's color

  scaffoldBackgroundColor: Colors.grey[100],

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.red[600]
  ),

  colorScheme: ColorScheme(
    brightness: .light , 
    primary: Colors.black ,
    onPrimary: const Color(0xFFFF8888), 
    inversePrimary: Colors.white, 
    secondary: Colors.grey[600]!, 
    onSecondary: Colors.grey[500]!, 
    error: Colors.red[800]!, 
    onError: Colors.red[800]!, 
    surface: const Color(0xFFD32F2F), 
    inverseSurface: const Color(0xFFF49292),
    onSurface: const Color(0xFFE34A4A) ,
  ),

  fontFamily: "Rubik" ,
  
);


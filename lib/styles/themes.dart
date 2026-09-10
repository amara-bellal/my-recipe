

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

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




ThemeData darkmode = ThemeData(

  primaryColor: Colors.white ,   // titles and icons's color

  scaffoldBackgroundColor: Colors.grey[900],

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.red[600]
  ),

  colorScheme: ColorScheme(
    brightness: .dark , 
    primary: Colors.white ,
    onPrimary: const Color(0xFFF65555), 
    inversePrimary: Colors.black, 
    secondary: Colors.grey[600]!, 
    onSecondary: Colors.grey[500]!, 
    error: Colors.red[800]!, 
    onError: Colors.red[800]!, 
    surface: const Color(0xFFD32F2F), 
    inverseSurface: const Color(0xFFF46666),
    onSurface: const Color(0xFFE34A4A) ,
  ),

  fontFamily: "Rubik" ,
  
  
  
);




class ThemeProvider extends ChangeNotifier{

  ThemeData theme = lightmode ;

  bool get isDarkmode => theme == darkmode ;



  ThemeProvider(){
    _getTheme();
  }


  Future<void> _getTheme() async{

    final box = await Hive.openBox("theme");

    final bool storedTheme = box.get("darkmode" , defaultValue: false) as bool ;

    theme = (storedTheme)? darkmode : lightmode ;

    await box.close();

    notifyListeners();
  }

  Future<void> _saveTheme() async{
    
    final box = await Hive.openBox("theme");

    await box.put("darkmode" , isDarkmode )  ;


    await box.close();
  }

  void toggleTheme() async{
    theme = (isDarkmode)? lightmode : darkmode ;
    await _saveTheme();
    notifyListeners();
  }

}
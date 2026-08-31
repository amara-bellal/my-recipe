import 'package:flutter/material.dart';
import 'package:recipe/pages/home.dart';
import 'package:recipe/styles/themes.dart';

void main() {
  
  runApp(const MyApp());
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'وصفتي',
      
      theme: lightmode,
      
      home: HomePage(),

      routes: {
        "/" : (context) => HomePage() ,
        "/recipes" : (context) => HomePage() ,
        "/recipes/add" : (context) => HomePage() ,
        "/recipes/add/supplies" : (context) => HomePage() ,
        "/recipes/add/methods" : (context) => HomePage() ,
      },
    );
  }
}




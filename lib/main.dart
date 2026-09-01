import 'package:flutter/material.dart';
import 'package:recipe/models/routes.dart';
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
      
      debugShowCheckedModeBanner: false,

      title: 'my recipe',
      
      theme: lightmode,
      
      home: HomePage(),
      
      routes: {
        Routes.HOME.path          :   (context) => HomePage() ,
        Routes.SETTINGS.path      :   (context) => HomePage() ,
        Routes.SHOW_RECIPES.path  :   (context) => HomePage() ,
        Routes.ADD_RECIPE.path    :   (context) => HomePage() ,
        Routes.ADD_SUPPLIES.path  :   (context) => HomePage() ,
        Routes.ADD_METHODS.path   :   (context) => HomePage() ,
      },
    );

  }
}




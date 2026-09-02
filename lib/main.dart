import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:recipe/models/routes.dart';
import 'package:recipe/pages/home.dart';
import 'package:recipe/styles/themes.dart';

void main() async {

  Hive.initFlutter();
  
  
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
        RoutePages.HOME.path          :   (context) => HomePage() ,
        RoutePages.SETTINGS.path      :   (context) => HomePage() ,
        RoutePages.SHOW_RECIPES.path  :   (context) => HomePage() ,
        RoutePages.ADD_RECIPE.path    :   (context) => HomePage() ,
        RoutePages.ADD_SUPPLIES.path  :   (context) => HomePage() ,
        RoutePages.ADD_STEPS.path   :   (context) => HomePage() ,
      },
    );

  }
}




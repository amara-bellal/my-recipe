import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:recipe/models/routes.dart';
import 'package:recipe/models/state%20management/cubit_state.dart';
import 'package:recipe/pages/home.dart';
import 'package:recipe/pages/recipes/add/add_recipe.dart';
import 'package:recipe/pages/recipes/list_recipes.dart';
import 'package:recipe/styles/themes.dart';

void main() async {

  await Hive.initFlutter();
  
  
  runApp(
    BlocProvider<RecipeStateBloc>(
      create: (context) => RecipeStateBloc() ,
      child: ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
          child: const MyApp(),
        )
    )
  );
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      
      debugShowCheckedModeBanner: false,

      title: 'my recipes',
      
      theme: context.watch<ThemeProvider>().theme ,
      
      home: HomePage(),
      
      routes: {
        RoutePages.HOME.path          :   (context) => HomePage() ,
        RoutePages.SHOW_RECIPES.path  :   (context) => ListRecipes() ,
        RoutePages.ADD_RECIPE.path    :   (context) => AddRecipePage() ,
      },
    );

  }
}




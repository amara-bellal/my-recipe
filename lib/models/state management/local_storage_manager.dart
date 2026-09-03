

import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe/models/state%20management/recipe.dart';

class HiveManager {

  Future<List<Recipe>> getRecipes() async{
    final box = await Hive.openBox("recipes");
    final mapRecipes = box.get("recipes" , defaultValue: <Map<String ,dynamic>>[]) ;
    print("$mapRecipes in get func");
    final List<Recipe> recipes = mapRecipes.map<Recipe>( (e) => Recipe.fromMap(e)).toList();
    await box.close();
    return recipes ;
  }

  Future<void> updateRecipes(List<Recipe> recipes) async{
    final box = await Hive.openBox("recipes");
    await box.add("recipes");
    final mapRecipes = recipes.map((e) => e.toMap()).toList();
    await box.put("recipes", mapRecipes);
    await box.close();
  }


}
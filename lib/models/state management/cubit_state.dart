



import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/models/state%20management/recipe.dart';
import "package:recipe/models/state management/local_storage_manager.dart";

class RecipeStateBloc extends Cubit<List<Recipe>?>{

  final HiveManager hive = new HiveManager();

  RecipeStateBloc() : super(null);


  void leaveRecipes(){
    emit(null);
  }

  Future<void> getRecipes() async{
    final recipes = await hive.getRecipes() ;
    emit(recipes);
  }

  Future<void> addNewRecipe(Recipe recipe) async{
    final newListRecipes = [...(state!) , recipe] ;
    await update(newListRecipes);
  }

  Future<void> update(List<Recipe> recipes) async{
     await hive.updateRecipes(recipes);
     emit(recipes);
  }


  void setImage(int recipeIndex , Uint8List bytes){
    state?[recipeIndex].setImage(bytes);
  }



  void addStep(int recipeIndex , String step , int? index){
     state?[recipeIndex].addStep(step , index);
  }


  void addSupplie(int recipeIndex , String supplie){
    state?[recipeIndex].addSupplie(supplie);
  }


  void modifyStep(int recipeIndex , String step , int index){
    state?[recipeIndex].modifyStep(step, index) ;
  }

  void modifySupplie(int recipeIndex , String supplie , int index){
    state?[recipeIndex].modifySupplie(supplie, index) ;
  }

  void removeStep(int recipeIndex , int index){
    state?[recipeIndex].removeStep(index);
  }

  void removeSupplie(int recipeIndex , int index){
    state?[recipeIndex].removeSupplie(index);
  }

}
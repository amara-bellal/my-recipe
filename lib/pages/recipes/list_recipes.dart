


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/components/LoadingCircle.dart';
import 'package:recipe/components/appbar.dart';
import 'package:recipe/components/emptyPage.dart';
import 'package:recipe/models/state%20management/cubit_state.dart';
import 'package:recipe/models/state%20management/recipe.dart';

class ListRecipes extends StatelessWidget{

   ListRecipes({super.key});



  @override
  Widget build(BuildContext context) {
    
    context.read<RecipeStateBloc>().leaveRecipes() ;
    print("start");
    context.read<RecipeStateBloc>().getRecipes() ;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      
      appBar: AppBarWidget(title: "وصفاتي", context: context , hasLeftIcon: true ),
      
      body: BlocBuilder<RecipeStateBloc , List<Recipe>?>(
          builder: (context , state){
            print("$state in blocbuilder");
            if(state == null) return LoadingCircle();
            
            if(state.length == 0) return Nothing(text: "لا توجد اي وصفة");
            
            return ListView.builder(
              itemCount: state.length ,
              itemBuilder: (context , index){
                final recipe = state[index];
                return Text("${recipe.steps}");
              }
              );
          } 
        ),
    );
    
  }

}
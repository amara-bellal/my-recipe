


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/components/LoadingCircle.dart';
import 'package:recipe/components/RecipeCard.dart';
import 'package:recipe/components/appbar.dart';
import 'package:recipe/components/emptyPage.dart';
import 'package:recipe/models/state%20management/cubit_state.dart';
import 'package:recipe/models/state%20management/recipe.dart';



enum SortMode{
  FAVORABLE , DATE , NAME
}




class ListRecipes extends StatefulWidget{

   ListRecipes({super.key});

  @override
  State<ListRecipes> createState() => _ListRecipes();

}





class _ListRecipes extends State<ListRecipes>{


  SortMode _sortmode = .FAVORABLE ;
  

  @override
  Widget build(BuildContext context) {
    
    context.read<RecipeStateBloc>().leaveRecipes() ;
    print("start");
    context.read<RecipeStateBloc>().getRecipes() ;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      
      appBar: AppBarWidget(title: "وصفاتي", context: context , hasLeftIcon: true ),
      
      body: Column(
        children: [
          
          Container(
            
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inverseSurface, 
              
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(100) ,
                  offset: Offset(0, 5) ,
                  blurRadius: 2.0 , 
                ),
              ]
            ),

            padding: EdgeInsets.all(15.0),
            child: Row(
              textDirection: .rtl,
              mainAxisAlignment: .spaceBetween,
              children: [
                
                Text(": ترتيب المكونات على حسب" , 
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary ,
                    fontSize: 18,
                  ),
                ),

                
                DropdownButton<SortMode>(
                  value: _sortmode,
                  items: [
                    DropdownMenuItem(child: Text("date") , value: .DATE,),
                    DropdownMenuItem(child: Text("favorable") , value: .FAVORABLE,),
                    DropdownMenuItem(child: Text("name") , value: .NAME,),
                  ], 
                  onChanged: (value){
                    setState(() {
                      if(value == null) return ;
                      _sortmode = value ;
                    });
                  }
                  )


              ],
            ),
          )
          ,
          Expanded(
            child: BlocBuilder<RecipeStateBloc , List<Recipe>?>(
                builder: (context , state){
                  print("$state in blocbuilder");
                  if(state == null) return LoadingCircle();
                  
                  if(state.length == 0) return Nothing(text: "لا توجد اي وصفة");
            
                  state.sort((r1 , r2){
                    switch(_sortmode){
                      case .FAVORABLE :
                        return r1.compareTo(r2);
                      case .NAME :
                        return r1.name.compareTo(r2.name);
                      case .DATE :
                        return r2.dateCreated.compareTo(r1.dateCreated);
                    }
                  });
                  
                  return ListView.separated(
                    itemCount: state.length ,
            
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0 , vertical: 20),
                      child: Divider(color: Theme.of(context).colorScheme.surface , radius: BorderRadius.circular(10) ,),
                    ),
            
                    itemBuilder: (context , index){
                      final recipe = state[index];
                      return RecipeCard(recipe: recipe);
                    }
                    );
                } 
              ),
          ),
        ],
      ),
    );
    
  }

}
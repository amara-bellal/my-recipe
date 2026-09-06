



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/components/LoadingCircle.dart';
import 'package:recipe/models/state%20management/cubit_state.dart';
import 'package:recipe/models/state%20management/recipe.dart';
import 'package:recipe/pages/recipes/add/add_recipe.dart';
import 'package:recipe/pages/recipes/recipe_information.dart';


String toFixNumberLetters(int num , int length){
  final String number = num.toString();
  String result = "" ;
  for(int i = 0 ; i < length - number.length ; i++){
    result += "0";
  }
  result += number ;
  return result ;
}



class RecipeCard extends StatelessWidget{
  
  final Recipe recipe;

  const RecipeCard({super.key , required this.recipe});

  @override
  Widget build(BuildContext context) {

    final shadowBox = [
                BoxShadow(
                  color: Colors.black ,
                  offset: Offset(0, 5),
                  blurRadius: 5.0,
                ),
              ];

    final date = recipe.dateCreated ;
    final String dateText = "${toFixNumberLetters(date.hour , 2)}:${toFixNumberLetters(date.minute , 2)}   ${toFixNumberLetters(date.day , 2)}-${toFixNumberLetters(date.month , 2)}-${toFixNumberLetters(date.year , 4)}";

    return Padding(
      key: Key(recipe.dateCreated.toString()),
      padding: EdgeInsets.all(15.0),
      child: Column(
        spacing: 0,
        children: [
          Container(
            clipBehavior: .hardEdge,
            padding: EdgeInsets.all(15.0),
            alignment: .centerLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10) , topRight: Radius.circular(10)),
              color: Theme.of(context).colorScheme.inversePrimary ,
              boxShadow: shadowBox ,
            ),
            child: Column(
              crossAxisAlignment: .end,
              spacing: 8,
              children: [
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AddRecipePage(recipe: recipe,)));
                          }, 
                          icon: Icon(Icons.edit)),
                        
                        IconButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeInformation(recipe: recipe,)));
                          }, 
                          icon: Icon(Icons.remove_red_eye)),
                        
                        

                      ],
                    )
                    ,
                    Text(dateText , style: TextStyle(color: Theme.of(context).colorScheme.secondary.withAlpha(200) , ),),
                  ],
                )
                ,
                
                Text(recipe.name , style: TextStyle(color: Theme.of(context).colorScheme.primary , fontSize: 21 , fontWeight: .bold),),

                
                Row(
                  textDirection: .rtl,
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                          onPressed: (){
                            // track recipe
                          } ,
                          child: Row(

                            textDirection: .rtl,
                            spacing: 6,
                            children: [
                              Icon(Icons.checklist , color: Theme.of(context).primaryColor,),
                              Text("تتبع الوصفة" , style: TextStyle(color: Theme.of(context).primaryColor , fontSize: 16),  )
                            ],
                          ),
                        ),
                    )
                    ,
                    IconButton(
                      iconSize: 10,
                      onPressed: (){
                        recipe.isFavorable = !recipe.isFavorable ;
                        context.read<RecipeStateBloc>().updateState();
                      }, 
                      icon: Icon( (!recipe.isFavorable)? Icons.star_border_rounded : Icons.star_rounded ,
                        color: Colors.amber[700],
                        size: 30,
                      )
                    ) ,
                  ],
                ),
              ],
            ),
          ),

          Container(
            height: 350,
            clipBehavior: .hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10) , bottomRight: Radius.circular(10)),
              color: Theme.of(context).colorScheme.inversePrimary ,
              boxShadow: shadowBox,
            ),
            child: Image.memory(recipe.image ,
              fit: .fitHeight,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded){
                if(frame == 0 || wasSynchronouslyLoaded) return child ;
                else return LoadingCircle();
              },
            ),
          )
        ],
      ),

    );
  }

}
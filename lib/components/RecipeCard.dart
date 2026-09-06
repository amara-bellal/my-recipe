



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/components/LoadingCircle.dart';
import 'package:recipe/models/state%20management/cubit_state.dart';
import 'package:recipe/models/state%20management/recipe.dart';

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
            child: Row(
              textDirection: .rtl,
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(recipe.name , style: TextStyle(color: Theme.of(context).colorScheme.primary , fontSize: 20),),
                IconButton(
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
                if(frame == 0) return child ;
                else return LoadingCircle();
              },
            ),
          )
        ],
      ),

    );
  }

}
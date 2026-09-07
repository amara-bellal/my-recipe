





import 'package:flutter/material.dart';
import 'package:recipe/components/LoadingCircle.dart';
import 'package:recipe/models/state%20management/recipe.dart';

class DefinisionRecipe extends StatelessWidget{

  final Recipe recipe;

  const DefinisionRecipe({super.key , required this.recipe});


  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: EdgeInsets.all(16.0) ,
        child: Column(
          crossAxisAlignment: .center,
          mainAxisAlignment: .start,
          spacing: 10,
          children: [
            SizedBox(height: 70,) ,
            Text(recipe.name , style: TextStyle(color: Theme.of(context).colorScheme.primary , fontWeight: .bold , fontSize: 35), textAlign: .center,) ,
            SizedBox(height: 20,) ,
            Container(
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusGeometry.circular(20) ,
                color: Theme.of(context).colorScheme.inversePrimary , 
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 7) ,
                    blurRadius: 10.0 ,
                    color: Colors.black.withAlpha(200),
                    spreadRadius: 0.5
                  )
                ],
              ),
              clipBehavior: .hardEdge,
              child: Image.memory(recipe.image , fit: BoxFit.fitHeight, frameBuilder: (context, child, frame, wasSynchronouslyLoaded){
                return (frame != 0 && !wasSynchronouslyLoaded)? LoadingCircle() : child ;
              },),
            ) ,

          ],
        ),
      );
    
  }

}
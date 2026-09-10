


import 'package:flutter/material.dart';
import 'package:recipe/models/state%20management/recipe.dart';
import 'package:recipe/pages/recipes/recipe_information.dart';

class EndTrackRecipe extends StatelessWidget{

  final Recipe recipe;

  const EndTrackRecipe({super.key , required this.recipe});

  @override
  Widget build(BuildContext context) {

    return Center(
        child: Column(
          spacing: 30,
          crossAxisAlignment: .center,
          mainAxisAlignment: .center,
          children: [
            Icon(
              Icons.star_rounded ,
              color: Colors.amber[600],
              size: 200,
            ),

            SizedBox(height: 40,),
      
            Text("تهانينا لقد أنهيت وصفتك" , 
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary ,
                fontSize: 25 ,
                fontWeight: .bold ,
              ),
              textDirection: .rtl,
            ),
      
            SizedBox(
              width: 120,
              child: ElevatedButton(
                
              
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.surface),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: .circular(200))),
                    padding: .all(EdgeInsets.symmetric(vertical:  10 , horizontal: 15)),
                    elevation: .all(2.0)
                  ),
                  onPressed:(){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RecipeInformation(recipe: recipe)));
                  }, 
                  child: Row(
                    mainAxisAlignment: .center,
                      spacing: 10,
                      children: [
                        Text("خروج" , style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20
                        ),
                      ),
                        Icon(Icons.logout_outlined , color: Theme.of(context).primaryColor, size: 30,),
                      ],
                     )
                 ),
            )
                  
          ],
        ),
      
    );

  }

}
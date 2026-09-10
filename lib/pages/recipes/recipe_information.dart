


import 'package:recipe/components/LoadingCircle.dart';
import 'package:recipe/components/appbar.dart';
import 'package:recipe/components/setting/drawer_setting.dart';
import "package:recipe/models/state management/recipe.dart";
import 'package:flutter/material.dart';
import 'package:recipe/pages/recipes/add/add_recipe.dart';
import 'package:recipe/pages/recipes/track/track_recipe.dart';

class RecipeInformation extends StatelessWidget {

  final Recipe recipe ;

  const RecipeInformation({super.key , required this.recipe});



  @override
  Widget build(BuildContext context) {

    final BoxDecoration boxDecoration = BoxDecoration(
      color: Theme.of(context).colorScheme.inverseSurface ,
      borderRadius: .circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(100) ,
          offset: Offset(0, 5) ,
          blurRadius: 5.0 ,
        )
      ]
    );

    final BoxDecoration boxDecorationStep = BoxDecoration(
      color: Theme.of(context).colorScheme.inversePrimary ,
      borderRadius: .circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(100) ,
          offset: Offset(0, 5) ,
          blurRadius: 5.0 ,
        )
      ]
    );

    final TextStyle titleStyle = TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: .bold ,
              fontSize: 22 ,
            );

    final TextStyle textStyle = TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 18 ,
            );

    
    return Scaffold(
      appBar: AppBarWidget(
        hasLeftIcon: true,
        title: "معلومات الوصفة", 
        context: context
      ),

      drawer: SettingsDrawer(),

      body: ListView(
        scrollDirection: .vertical,
        padding: EdgeInsets.symmetric(vertical: 25 , horizontal: 16),
        children: [
          Text("اسم الوصفة" , style: titleStyle,
            textDirection: .rtl,
          ),

          SizedBox(height: 12,),

          Container(
            padding: EdgeInsets.all(16),
            decoration: boxDecoration,
            child: Text(recipe.name , style: textStyle, textDirection: .rtl,),
          ),

          SizedBox(height: 40,),

          Text("صورة الطبخة" , style: titleStyle,
            textDirection: .rtl,
          ),

          SizedBox(height: 15,),

          Container(
            height: 350,
            clipBehavior: .hardEdge,
            decoration: boxDecoration,
            child: Image.memory(recipe.image ,
                fit: .fitHeight,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded){
                  if(frame == 0 || wasSynchronouslyLoaded) return child ;
                  else return LoadingCircle();
                },
              ),
          ),

          SizedBox(height: 40,),

          Text("مكونات الوصفة" , style: titleStyle,
            textDirection: .rtl,
          ),

          SizedBox(height: 15,),

          ...recipe.supplies.map((supplie) => Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: 15),
            decoration: boxDecoration,
            child: Text(supplie , style: textStyle, textDirection: .rtl,),
          ),) ,

          SizedBox(height: 40,),

          Text("خطوات الوصفة" , style: titleStyle,
            textDirection: .rtl,
          ),

          SizedBox(height: 20,),

          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: recipe.steps.length,

            itemBuilder: (context, index) => Container(
              decoration: boxDecorationStep,
              margin: EdgeInsets.only(bottom: 15),
              alignment: .topRight,
              clipBehavior:  .hardEdge,
              child: Column(
                crossAxisAlignment: .end,
                spacing: 0,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.inverseSurface,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10))
                    ),
                    width: 50,
                    height: 30,
                    child: Center(
                      child: Text((index + 1).toString() , style: TextStyle(color: Theme.of(context).primaryColor , fontWeight: .bold) ,),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(bottom: 15 , left: 15 , right: 15 , top: 5) ,
                    child: Text(recipe.steps[index] , style: textStyle, textDirection: .rtl,),
                  )
                ],
              ),
            ),

          ),

          SizedBox(height: 150,),


        ],
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: .center,
          spacing: 15,
          children: [
             Expanded(
               child: ElevatedButton(
                
                    style: ButtonStyle(
                      elevation: .all(5.0)
                    ),
                    onPressed: (){
                      // track recipe
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TrackRecipePage(recipe: recipe)));
                    } ,
                    child: Row(
                      mainAxisAlignment: .center,
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
        
            
              Expanded(
                child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: .all(5.0)
                    ),
                    onPressed: (){
                      // track recipe
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddRecipePage(recipe: recipe)));
                    } ,
                    child: Row(
                      mainAxisAlignment: .center,
                      textDirection: .rtl,
                      spacing: 6,
                      children: [
                        Icon(Icons.edit , color: Theme.of(context).primaryColor,),
                        Text("تعديل الوصفة" , style: TextStyle(color: Theme.of(context).primaryColor , fontSize: 16),  )
                      ],
                    ),
                  ),
              ),
            
            
          ],
        ),
      ),

      floatingActionButtonLocation: .centerFloat,

    );
    
  }



}
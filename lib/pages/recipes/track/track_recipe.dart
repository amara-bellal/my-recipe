




import 'package:flutter/material.dart';
import 'package:recipe/components/appbar.dart';
import 'package:recipe/components/track%20recipe/definision.dart';
import 'package:recipe/components/track%20recipe/track_supplies.dart';
import 'package:recipe/models/state%20management/recipe.dart';

class TrackRecipePage extends StatefulWidget{

  final Recipe recipe;

  const TrackRecipePage({super.key , required this.recipe});


  @override
  State<TrackRecipePage> createState() => _TrackRecipePage(recipe: recipe);
}

class _TrackRecipePage extends State<TrackRecipePage>{
  
  final Recipe recipe;

  int _page = 0 ;
  bool _isDone = true;
  PageController pageController = PageController(initialPage: 0);

  _TrackRecipePage({required this.recipe});


  void setDone(bool value){
    setState(() {
      _isDone = value;
    });
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      appBar: AppBarWidget(title: "تتبع الوصفة", context: context , hasLeftIcon: true),

      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          DefinisionRecipe(recipe: recipe ) ,
          TrackSupplies(recipe: recipe, makeDone: setDone)
        ],
      ),

      floatingActionButtonLocation: .centerFloat,

      floatingActionButton: (_page == 3)? null : FloatingActionButton(

        backgroundColor: Theme.of(context).colorScheme.surface,

        child: Icon((_page == 2)? Icons.done : Icons.arrow_forward_ios_rounded  , 
                    color: Theme.of(context).primaryColor.withAlpha((_isDone)? 255 : 120), 
                    size: 35,),

        onPressed:(!_isDone)? null : (){
          setState(() {
            
            _isDone = false;
            
            if(_page < 3){
              _page ++ ;
            }

            pageController.nextPage(duration: Duration(milliseconds: 400), curve: Curves.easeOut);


          });

        },
      ),

    );
    
  }

}
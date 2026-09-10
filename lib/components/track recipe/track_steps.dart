


import 'package:flutter/material.dart';
import 'package:recipe/models/state%20management/recipe.dart';




class TrackSteps extends StatefulWidget{

  final Recipe recipe ;
  final void Function(bool) makeDone ;

  TrackSteps({super.key , required this.recipe , required this.makeDone}){

  }


  @override
  State<TrackSteps> createState() => _TrackSteps(recipe: recipe, makeDone: makeDone);
  

}


class _TrackSteps extends State<TrackSteps>{


  final void Function(bool) makeDone;
  late List<String> steps ;

  int _currentStep = 0 ;

  _TrackSteps({required Recipe recipe , required this.makeDone}){
    steps = recipe.steps;
  }


  
  @override
  Widget build(BuildContext context) {

    return Column(
          children: [
            Container(
              width: .infinity,
              alignment: .center,
              padding: EdgeInsets.symmetric(vertical: 25.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inverseSurface ,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 5) ,
                    color: Colors.black.withAlpha(100),
                    blurRadius: 5.0 ,
                  )
                ]
              ),

              child: Text("اتباع خطوات الوصفة" , style: TextStyle(
                  color: Theme.of(context).colorScheme.primary ,
                  fontSize: 25 ,
                  fontWeight: .bold
                    ),
                  ),
            )
            ,
            SizedBox(height: 40,)
            ,
            
            AnimatedOpacity(
              opacity: (_currentStep == steps.length)? 0 : 1 ,
              duration: Duration(milliseconds: 200),
              child: Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  borderRadius: .circular(80) ,
                  color: Theme.of(context).colorScheme.surface ,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 3),
                      color: Colors.black.withAlpha(120),
                      blurRadius: 5.0
                    )
                  ]
                ),
                alignment: .center,
                child: (_currentStep == steps.length)? null : Text((_currentStep + 1).toString() , style: TextStyle(
                  color: Theme.of(context).primaryColor ,
                  fontWeight: .bold ,
                  fontSize: 30 ,
                ),),
              ),
            ),
            SizedBox(height: 20,)
            ,
            Container(
              alignment: .center,
              width: .infinity,
              height: 320,
              decoration: BoxDecoration(
            //    color: Theme.of(context).scaffoldBackgroundColor.withAlpha(0),
              ),
              clipBehavior: .hardEdge,
              child: Stack(
            
                children: List.generate(
                  steps.length + 1 ,
            
                  (index) => AnimatedOpacity(
                    key: Key(index.toString()),
                    opacity: (index == _currentStep)? 1 : 0, 
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                      child: Center(
                        child: AnimatedSlide(
                          offset: Offset(0 , ((index < _currentStep)? -4 : ((index > _currentStep)? 7 : 0))),
                          duration: Duration(milliseconds: 300) ,
                          
                          child: 
                            (index == steps.length)?
                            Container(
                              child: Text("! اكتملت الوصفة" , style: TextStyle(
                                color: Theme.of(context).colorScheme.primary ,
                                fontSize: 25 ,
                                fontWeight: .bold
                              ),),
                            )
                            :
                           Container(
                            width: MediaQuery.widthOf(context) - 50,
                            padding: EdgeInsets.symmetric(vertical: 20 , horizontal: 18.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.inversePrimary ,
                              borderRadius: .circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(100),
                                  offset: Offset(0, 5),
                                  blurRadius: 5.0 ,
                                ),
                              ] ,
                            ),
                            child: Text(steps[index] , textDirection: .rtl , style: TextStyle(
                              color: Theme.of(context).colorScheme.primary ,
                              fontSize: 19
                            ),),
                          ),
                        ),
                      ),
                    ),
                    )
                ),
              ),
            
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: .center,
              spacing: 20,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.surface),
                    shape: .all(CircleBorder()),
                    padding: .all(EdgeInsets.all(10)),
                    elevation: .all(2.0)
                  ),
                  onPressed: (_currentStep == 0)? null : (){
                    setState(() {
                      _currentStep -- ;
                      makeDone(false);
                    });
                  }, 
                  child: Icon(Icons.undo_rounded , color: Theme.of(context).primaryColor.withAlpha((_currentStep == 0)? 120 : 255), size: 30,)
                ),

                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.surface),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: .circular(200))),
                    padding: .all(EdgeInsets.symmetric(vertical:  10 , horizontal: 15)),
                    elevation: .all(2.0)
                  ),
                  onPressed:(_currentStep == steps.length)? null : (){
                    setState(() {
                      _currentStep ++ ;
                      if(_currentStep == steps.length) makeDone(true);
                    });
                  }, 
                  child: Opacity(
                    opacity: (_currentStep == steps.length)? 0.5 : 1,
                    child: Row(
                      spacing: 10,
                      children: [
                        Text("الخطوة التالية" , style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                        Icon(Icons.arrow_circle_right_outlined , color: Theme.of(context).primaryColor, size: 30,),
                      ],
                    )
                  )
                )
              ],
            )
          ],
        

    );

  }

}



import 'package:flutter/material.dart';
import 'package:recipe/models/Tracker.dart';
import 'package:recipe/models/state%20management/recipe.dart';







class TrackSupplies extends StatefulWidget{

  final Recipe recipe ;
  final void Function(bool) makeDone;

  const TrackSupplies({super.key , required this.recipe , required this.makeDone});


  State<TrackSupplies> createState() => _TrackSupplies(recipe: recipe , makeDone: makeDone) ;

}



class _TrackSupplies extends State<TrackSupplies>{


  final void Function(bool) makeDone;
  late List<Tracker> supplies ;

  _TrackSupplies({required Recipe recipe , required this.makeDone}){
    supplies = recipe.supplies.map((e) => Tracker(tracked: e)).toList();
  }



  void makeDoneSupplie(int index , bool value){
    setState(() {
      supplies[index].done = value ;
      if(supplies.map((e) => e.done).reduce((v , e) => v && e)){
        makeDone(true);
      }
      else{
        makeDone(false);
      }
    });
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

          child: Text("جمع مكونات الوصفة" , style: TextStyle(
              color: Theme.of(context).colorScheme.primary ,
              fontSize: 25 ,
              fontWeight: .bold
                ),
               ),
        )
        ,
        Expanded(
          child: ListView.separated(
              padding: EdgeInsets.all(16.0),
              separatorBuilder: (context, index) => SizedBox(height: 15,),
              itemCount: supplies.length,
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.symmetric( horizontal: 16.0 , vertical: 10.0),
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
          
                child: Row(
                  textDirection: .rtl,
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Expanded(
                      child: Text(supplies[index].tracked , style: TextStyle(
                        color: Theme.of(context).colorScheme.primary ,
                        fontSize: 18 ,
                        decoration: (supplies[index].done)? .lineThrough : null ,
                        decorationColor: Theme.of(context).colorScheme.surface ,
                        decorationThickness: 2 ,
                        
                        ),
                        textAlign: .end,
                      ),
                    ) ,
          
                    Checkbox(
                      activeColor: Theme.of(context).colorScheme.surface,
                      checkColor: Theme.of(context).primaryColor,
                      value: supplies[index].done, 
                      onChanged: (value){
                        if(value == null)  return ;
                        makeDoneSupplie(index, value);
                      })
                  ],
                ),
          
              ),
                  
          ),
        ),
      ],
    );
    
  }

}
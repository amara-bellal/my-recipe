



import 'package:flutter/material.dart';

class AddStepsPage extends StatelessWidget{

  final List<String> steps;
  final int? chosenField ;
  final Function(int , String) modifyStep ;
  final Function(int , int) swapSteps ; 
  final Function(int ) removeStep ; 
  final Function(int) editStep ;

  final TextEditingController editStepController ;

  const AddStepsPage({super.key , required this.steps , this.chosenField , 
                      required this.modifyStep , required this.swapSteps ,
                      required this.removeStep , required this.editStep ,
                      required this.editStepController ,

                      });


  @override
  Widget build(BuildContext context) {

  
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: .end,
        children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              textDirection: .rtl,
              children: [
                Text("خطوات الوصفة" , style: TextStyle(color: Theme.of(context).colorScheme.primary , fontSize: 20 ), ),
                IconButton(
                  onPressed: (chosenField != null)? null : (){editStep(steps.length);}, 
                  color: Theme.of(context).colorScheme.surface,
                  icon: Icon(Icons.add , color: Theme.of(context).colorScheme.primary, ),
                )
              ],
            ) 
            ,
              SizedBox(height: 25,)
            ,
            Expanded(
              child: ListView.separated(
                clipBehavior: .none,
                separatorBuilder: (context , index) => SizedBox(height: 25,),
                itemCount: steps.length ,
                itemBuilder: (context , index){
                  final step = steps[index];
                  
                    return Column(
                      children: [
                        Stack(
                          children: [
                            
                        
                            Container(
                                padding: EdgeInsets.only(top : 40 , left: 15 , right: 15 , bottom: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadiusGeometry.circular(20) ,
                                  color: Theme.of(context).colorScheme.inversePrimary , 
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 7) ,
                                      blurRadius: 10.0 ,
                                      color: Colors.black.withAlpha(100),
                                      spreadRadius: 1
                                    )
                                  ]
                                ),
                                child: Column(
                                  mainAxisAlignment: .start,
                                  crossAxisAlignment: .start,
                                  textDirection: .rtl,
                                  children: [
                                    (chosenField != index)?
                                    Text(step , style: TextStyle(color: (chosenField == null)? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSecondary, 
                                                fontSize: 18 ,), 
                                                textDirection: .rtl,
                                                ) 
                                    :
                                    TextField(
                                      controller: editStepController,
                                      cursorColor: Theme.of(context).colorScheme.surface,
                                      cursorErrorColor: Theme.of(context).colorScheme.surface,
                                      textDirection: .rtl,
                                      style: TextStyle(color: Theme.of(context).colorScheme.primary),
                                      decoration: InputDecoration(
                                        hintText: "أدخل الخطوة التالية هنا" ,
                                        hintTextDirection: .rtl,
                                    
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10) ,
                                                      borderSide: BorderSide(color: Theme.of(context).colorScheme.surface) ),
                                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2) ,
                                                      borderSide: BorderSide(color: Theme.of(context).colorScheme.surface) ),
                                        
                                        
                                      ),
                                    )
                                    ,
                                    (chosenField != index)? Row(
                                      children: [
                                        IconButton(
                                          onPressed: (chosenField != null)? null: (){editStep(index);}, 
                                          icon: Icon(Icons.edit) ,
                                        ),
                              
                                        IconButton(
                                          onPressed: (chosenField != null)? null: (){removeStep(index);}, 
                                          icon: Icon(Icons.delete) ,
                                        ),
                                        
                                        
                                        IconButton(
                                            onPressed: (index == 0 || chosenField != null)? null : () => swapSteps(index , index - 1), 
                                            icon: Icon(Icons.arrow_upward) ,
                                        )
                                        ,
                                            
                                        IconButton(
                                            onPressed:(index == steps.length - 1 || chosenField != null)? null : () => swapSteps(index , index + 1), 
                                            icon: Icon(Icons.arrow_downward) ,
                                        )
                                        ,
                                        
                                      ],
                                    ):
                                    Row(
                        
                                      children: [
                                        IconButton(
                                          onPressed: (){
                                            if(editStepController.text == "") modifyStep(index , steps[index]);
                                            else modifyStep(index , editStepController.text);
                                          }, 
                                          icon: Icon(Icons.save) ,
                                        ),

                                        IconButton(
                                          onPressed: (){
                                            modifyStep(index , steps[index]);
                                          }, 
                                          icon: Icon(Icons.cancel))
                                      ],
                                    )
                                  ],
                                ) ,
                              
                              
                              
                            ),
                        
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 5, horizontal:  15),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.inverseSurface ,
                                  borderRadius: .only(bottomLeft:  Radius.circular(10) , topRight: Radius.circular(10)) ,
                                ),
                                child: Center(
                                  child: Text(
                                      (index + 1).toString() , 
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor ,
                                        fontSize: 12 ,
                                        fontWeight: .bold
                                      ),  
                                    ),
                                ),
                              ),
                            )
                            ,
                          ],
                        ),
                      ],
                    );
                  }
                
              ),
            ),
        ],
      )
    );

  
  }
}
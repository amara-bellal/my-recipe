



import 'package:flutter/material.dart';
import 'package:recipe/components/emptyPage.dart';

class AddStepsPage extends StatelessWidget{

  final List<String> steps;
  final int? chosenField ;
  final Function(int , String) modifyStep ;
  final Function(int , int) swapSteps ; 
  final Function(int ) removeStep ; 
  final Function(int) editStep ;
  final Function(int) addStepBetweenTwoSteps ;
  final FocusNode focusnode ;

  final TextEditingController editStepController ;


  final ScrollController scrollController = ScrollController();

  AddStepsPage({super.key , required this.steps , this.chosenField , 
                      required this.modifyStep , required this.swapSteps ,
                      required this.removeStep , required this.editStep ,
                      required this.editStepController , required this.focusnode,
                      required this.addStepBetweenTwoSteps
                      });


  @override
  Widget build(BuildContext context) {

  
    return Column(
        crossAxisAlignment: .end,
        children: [
            Container(
              color: Theme.of(context).colorScheme.inverseSurface,
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                textDirection: .rtl,
                children: [
                  Text("خطوات الوصفة" , style: TextStyle(color: Theme.of(context).colorScheme.primary , fontSize: 20 ), ),
                  MaterialButton(
                    onPressed:(chosenField == steps.length - 1 || chosenField == null)?(){
                        if(!steps.isEmpty) scrollController.animateTo(scrollController.position.maxScrollExtent , duration: Duration(milliseconds: 400) , curve: Curves.easeOut);
                        if(chosenField == null) editStep(steps.length);
                      } : null, 
                    shape: CircleBorder(),
                    color: Theme.of(context).colorScheme.onSurface,
                    disabledColor: Theme.of(context).colorScheme.onSurface,
                    child: Icon(Icons.add , color: Theme.of(context).primaryColor, ),
                  )
                ],
              ),
            ) 
            ,
            Expanded(
              child: (steps.isEmpty)?  
                  Nothing(text: "لا توجد أي خطوات بعد")
                  :
                  ListView.separated(
                    controller: scrollController,
                    padding: EdgeInsets.only(bottom: 150 , right: 15 , left: 15 , top: 15),
                    clipBehavior: .hardEdge,
                    separatorBuilder: (context , index) => SizedBox(height: 5,),
                    itemCount: steps.length ,
                    itemBuilder: (context , index){
                      final step = steps[index];
                      
                        return Column(
                          spacing: 5,
                          key: Key(steps[index]),
                          children: [
                            
                            MaterialButton(
                                padding: EdgeInsets.all(5),
                                shape: CircleBorder(),
                                color: Theme.of(context).colorScheme.onSecondary,
                                disabledColor: Theme.of(context).colorScheme.onSecondary.withAlpha(100),
                                onPressed: (chosenField != null)? null : (){
                                  addStepBetweenTwoSteps(index);
                                },
                                child: Icon(Icons.add , color: Theme.of(context).primaryColor,),
                              )

                            ,

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
                                          focusNode: focusnode,
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
                                              key: Key("edit"),
                                              onPressed: (chosenField != null)? null: (){editStep(index);}, 
                                              icon: Icon(Icons.edit) ,
                                            ),
                                  
                                            IconButton(
                                              key: Key("delete"),
                                              onPressed: (chosenField != null)? null: (){removeStep(index);}, 
                                              icon: Icon(Icons.delete) ,
                                            ),
                                            
                                            
                                            IconButton(
                                              key: Key("up"),
                                              onPressed: (index == 0 || chosenField != null)? null : () => swapSteps(index , index - 1), 
                                              icon: Icon(Icons.arrow_upward) ,
                                            )
                                            ,
                                                
                                            IconButton(
                                              key: Key("down"),
                                              onPressed:(index == steps.length - 1 || chosenField != null)? null : () => swapSteps(index , index + 1), 
                                              icon: Icon(Icons.arrow_downward) ,
                                            )
                                            ,
                                            
                                          ],
                                        ):
                                        Row(
                            
                                          children: [
                                            IconButton(
                                              key: Key("save"),
                                              onPressed: (){
                                                if(editStepController.text == "") modifyStep(index , steps[index]);
                                                else modifyStep(index , editStepController.text);
                                              }, 
                                              icon: Icon(Icons.check) ,
                                            ),
                
                                            IconButton(
                                              key: Key("cancel"),
                                              onPressed: (){
                                                modifyStep(index , steps[index]);
                                              }, 
                                              icon: Icon(Icons.close))
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
    );

  
  }
}
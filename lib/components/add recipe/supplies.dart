



import 'package:flutter/material.dart';
import 'package:recipe/components/emptyPage.dart';

class AddSuppliesPage extends StatelessWidget{

  final List<String> supplies;
  final int? chosenField ;
  final Function(int , String) modifySupplie ;
  final Function(int ) removeSupplie ; 
  final Function(int) editSupplie ;
  final FocusNode focusnode ;

  final TextEditingController editSupplieController ;


  final ScrollController scrollController = ScrollController();

  AddSuppliesPage({super.key , required this.supplies , this.chosenField , 
                      required this.modifySupplie , required this.removeSupplie , 
                      required this.editSupplie , required this.editSupplieController , 
                      required this.focusnode

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
                  Text("مكونات الوصفة" , style: TextStyle(color: Theme.of(context).colorScheme.primary , fontSize: 20 ), ),
                  MaterialButton(
                    shape: CircleBorder(),
                    color: Theme.of(context).colorScheme.onSurface,
                    disabledColor: Theme.of(context).colorScheme.onSurface.withAlpha(100),
                    onPressed: (){
                        if(!supplies.isEmpty) scrollController.animateTo(scrollController.position.maxScrollExtent , duration: Duration(milliseconds: 400) , curve: Curves.easeOut);
                        if(chosenField == null) editSupplie(supplies.length);
                      }, 
                    child: Icon(Icons.add , color: Theme.of(context).primaryColor) ,
                  )
                ],
              ),
            ) 
            ,
            Expanded(
              child: (supplies.isEmpty)?  
                  Nothing(text: "لا توجد أي مكونات بعد")
                  :
                  ListView.separated(
                    controller: scrollController,
                    padding: EdgeInsets.only(bottom: 150 , right: 15 , left: 15 , top: 15),
                    clipBehavior: .hardEdge,
                    separatorBuilder: (context , index) => SizedBox(height: 25,),
                    itemCount: supplies.length ,
                    itemBuilder: (context , index){
                      final supplie = supplies[index];
                      
                        return Column(
                          key: Key(supplies[index]),
                          children: [
                            
                                Container(
                                    padding: EdgeInsets.only(top : 15 , left: 15 , right: 15 , bottom: 5),
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
                                        Text(supplie , style: TextStyle(color: (chosenField == null)? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSecondary, 
                                                    fontSize: 18 ,), 
                                                    textDirection: .rtl,
                                                    ) 
                                        :
                                        TextField(
                                          focusNode: focusnode,
                                          controller: editSupplieController,
                                          cursorColor: Theme.of(context).colorScheme.surface,
                                          cursorErrorColor: Theme.of(context).colorScheme.surface,
                                          textDirection: .rtl,
                                          style: TextStyle(color: Theme.of(context).colorScheme.primary),
                                          decoration: InputDecoration(
                                            hintText: "أدخل المكون التالي هنا" ,
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
                                              onPressed: (chosenField != null)? null: (){editSupplie(index);}, 
                                              icon: Icon(Icons.edit) ,
                                            ),
                                  
                                            IconButton(
                                              key: Key("delete"),
                                              onPressed: (chosenField != null)? null: (){removeSupplie(index);}, 
                                              icon: Icon(Icons.delete) ,
                                            ),
                                            
                                            
                                            
                                          ],
                                        ):
                                        Row(
                            
                                          children: [
                                            IconButton(
                                              key: Key("save"),
                                              onPressed: (){
                                                if(editSupplieController.text == "") modifySupplie(index , supplies[index]);
                                                else modifySupplie(index , editSupplieController.text);
                                              }, 
                                              icon: Icon(Icons.check) ,
                                            ),
                
                                            IconButton(
                                              key: Key("cancel"),
                                              onPressed: (){
                                                modifySupplie(index , supplies[index]);
                                              }, 
                                              icon: Icon(Icons.close))
                                          ],
                                        )
                                      ],
                                    ) ,
                                  
                                  
                                  
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
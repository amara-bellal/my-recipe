



import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe/components/LoadingCircle.dart';


// ignore: must_be_immutable
class HeaderRecipe extends StatelessWidget{
  
  TextEditingController nameController ;

  Function(ImageSource) setImage;

  Uint8List? bytesImage ;

  HeaderRecipe({super.key , required this.nameController , required this.setImage , required this.bytesImage});




  @override
  Widget build(BuildContext context) {
    
      return Padding(
          padding: EdgeInsets.all(20.0) ,
          child : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: .end,
              spacing: 15.0,
              children: [
                Text("اسم الوصفة" , 
                  style: TextStyle(color:  Theme.of(context).colorScheme.primary , 
                                    fontSize: 20),
                  ) ,
              
                TextField(
                  controller: nameController,
                  cursorColor: Theme.of(context).colorScheme.surface,
                  cursorErrorColor: Theme.of(context).colorScheme.surface,
                  textDirection: .rtl,
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                  decoration: InputDecoration(
                    hintText: "أدخل اسم الطبخة هنا" ,
                    hintTextDirection: .rtl,
                
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10) ,
                                  borderSide: BorderSide(color: Theme.of(context).colorScheme.surface) ),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2) ,
                                  borderSide: BorderSide(color: Theme.of(context).colorScheme.surface) ),
                     
                    
                  ),
                )
                ,
                SizedBox(height: 30,)
                ,
                Text("صورة الطبخة" , 
                  style: TextStyle(color:  Theme.of(context).colorScheme.primary , 
                                    fontSize: 20),
                )
                ,
              
                Stack(
                  
                  clipBehavior: .none,
                  children: [

                    Container(
                      height: 350,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusGeometry.circular(20) ,
                        color: (bytesImage != null)?  Theme.of(context).colorScheme.inversePrimary : 
                                  Theme.of(context).colorScheme.onSecondary ,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 7) ,
                            blurRadius: 10.0 ,
                            color: Colors.black.withAlpha(200),
                            spreadRadius: 0.5
                          )
                        ]
                      ),

                      clipBehavior: .hardEdge,

                      child: (bytesImage == null)? 
                        Center(
                          child: Icon(Icons.image , color: Theme.of(context).colorScheme.secondary, size: 100,),
                        ) :
                        Image.memory(bytesImage! , fit: BoxFit.fitHeight, frameBuilder: (context, child, frame, wasSynchronouslyLoaded){
                          return (frame != 0 )? LoadingCircle() : child ;
                        },) ,
                    ),

                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Row(
                        spacing: 10,
                        children: [
                          FloatingActionButton(
                            shape: CircleBorder(),
                            clipBehavior: .none,
                            backgroundColor: Theme.of(context).colorScheme.surface,
                            onPressed: (){setImage(.camera);} ,  
                            child: Icon(Icons.camera_enhance, color: Theme.of(context).primaryColor, size:30)
                            ),
                          
                          FloatingActionButton(
                            shape: CircleBorder(),
                            clipBehavior: .none,
                            backgroundColor: Theme.of(context).colorScheme.surface,
                            onPressed: (){setImage(.gallery);} ,  
                            child: Icon(Icons.image, color: Theme.of(context).primaryColor , size: 30,)
                            )
                        ],
                      ),
                    )



                  ],
                )


                
              ],
            ),
          ) ,
        ) ;

    
  }

}
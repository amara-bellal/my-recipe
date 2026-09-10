



import 'package:flutter/material.dart';

class AlertPop extends StatelessWidget{

  final String message ;

  const AlertPop({super.key , required this.message});

  @override
  Widget build(BuildContext context) {
    
    return AlertDialog(
      alignment: .center,
      elevation: 20.0,
      backgroundColor: Theme.of(context).colorScheme.surface,
      actionsAlignment: .start,
      titlePadding: EdgeInsets.all(25.0),
      contentPadding: EdgeInsets.all(25),
      actionsPadding: EdgeInsets.all(25.0),
      shape: RoundedRectangleBorder(borderRadius: .circular(10)),
      title: Text("تحذير" , style: TextStyle(
          color: Theme.of(context).primaryColor , 
          fontWeight: .bold ,
          fontSize: 25 ,
        ),
        textDirection: .rtl,
      ),

      content: Text(message , style: TextStyle(
          color: Theme.of(context).primaryColor ,
          fontSize: 18 ,
        ),
        textDirection: .rtl,
      ),


      actions: [
        MaterialButton(
          color: Theme.of(context).colorScheme.onSurface,
          onPressed: (){
            Navigator.pop(context);
          }, 
          child: Text( "إلغاء" , style: TextStyle(color: Theme.of(context).primaryColor),),
        ),

        MaterialButton(
          color: Theme.of(context).colorScheme.onSurface,
          onPressed: (){
            Navigator.of(context).pop();
            print(Navigator.canPop(context));
            WidgetsBinding.instance.addPostFrameCallback((_){
              Navigator.of(context).pop();
            });
          }, 
          child: Text( "متأكد" , style: TextStyle(color: Theme.of(context).primaryColor),),
        ),
      ],



    );
    
  }

}







import 'package:flutter/material.dart';

class NavigateButton extends StatelessWidget{

  final String route;
  final String title;
  final IconData icon;

  const NavigateButton({super.key , required this.route , required this.title , required this.icon});

  @override
  Widget build(BuildContext context) {


    return  ElevatedButton(

        onPressed: (){
          Navigator.pushNamed(context, route);
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateColor.resolveWith((state){
              if(state.contains(WidgetState.pressed)) return Theme.of(context).colorScheme.onSurface;
              return Theme.of(context).colorScheme.surface;
            }),
          
          padding: WidgetStateProperty.resolveWith((state){
            return EdgeInsets.symmetric(horizontal: 10 , vertical: 7);
          }),

          elevation: .resolveWith((state){
            return 5;
          }),

          shadowColor: .resolveWith((state){
            return Colors.black ;
          }),

          alignment: .centerRight ,

          shape: .resolveWith((state){
            return RoundedRectangleBorder(borderRadius: .circular(20));
          })
        ),
        child:  Row(
            crossAxisAlignment: .center,
            mainAxisAlignment: .start,
            textDirection: .rtl,
            children: [
              Icon(icon , size: 35, color: Colors.white,) ,
              SizedBox(width: 25,),
              Text(title , style: TextStyle(color: Colors.white , fontSize: 18),),
            ],
          ),
    );   
  }

}
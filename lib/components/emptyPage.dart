


import 'package:flutter/material.dart';

class Nothing extends StatelessWidget{

  final String text ;

  const Nothing({super.key , required this.text});


  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: Column(
        mainAxisAlignment: .center,
        spacing: 30,
        children: [
          Image.asset("assets/images/static/emptyBox.png")
          ,
          Text(text , style: TextStyle(color: Theme.of(context).colorScheme.secondary , fontSize: 20),),
        ],
      ),
    );
    
  }
}
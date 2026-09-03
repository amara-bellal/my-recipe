


import 'package:flutter/material.dart';

class Nothing extends StatelessWidget{

  final String text ;

  const Nothing({super.key , required this.text});


  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: Text(text),
    );
    
  }
}
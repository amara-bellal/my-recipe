


import 'package:flutter/material.dart';

class LoadingCircle extends StatelessWidget{
  
  const LoadingCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.surface,),);
    
  }

}
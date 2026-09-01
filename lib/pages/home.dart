




import 'package:flutter/material.dart';
import 'package:recipe/components/appbar.dart';

class HomePage extends StatelessWidget{

  HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBarWidget(
        context: context,
        title: "الصفحة الرئيسية" ,
      ),

      drawer: Drawer(),
    );
    
  }
}
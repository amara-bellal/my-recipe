




import 'package:flutter/material.dart';
import 'package:recipe/components/appbar.dart';
import 'package:recipe/components/navigate_button.dart';
import 'package:recipe/models/routes.dart';

class HomePage extends StatelessWidget{

  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBarWidget(
        context: context,
        title: "الصفحة الرئيسية" ,
      ),

      drawer: Drawer(),

      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Column(
              mainAxisAlignment: .center,
              children: [
                SizedBox(height: 50,)
                ,
              Image.asset("assets/images/recipe_logo.png")
                ,
                SizedBox(
                  height: 65,
                ) ,
                NavigateButton(route: RoutePages.SHOW_RECIPES.path , title: "عرض جميع وصفاتي" , icon: Icons.list_alt),
                SizedBox(
                  height: 30,
                ),
                NavigateButton(route: RoutePages.ADD_RECIPE.path , title: "إضافة وصفة جديدة" , icon: Icons.add,)
              ],
            ),
          ),
        );
    
  }
}




import 'package:flutter/material.dart';





PreferredSizeWidget AppBarWidget({ 
                bool hasLeftIcon = true , 
                IconData leftIcon = Icons.menu , 
                bool hasRightIcon = true , 
                IconData rightIcon = Icons.settings,
                VoidCallback? onLeftIconPressed ,
                VoidCallback? onRightIconPressed ,
                required String title ,
                required BuildContext context ,
                }){

    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      centerTitle: true,
      title: Text(title , 
                  style: TextStyle(
                      color: Theme.of(context).primaryColor ,
                      fontWeight: .bold ,
                      fontSize: 20 ,
                    )
                  ),
      actions: 
        (!hasRightIcon)? null :
        [
          IconButton(
            onPressed: onRightIconPressed ?? (){
              Navigator.pushNamed(context, "/settings");
            }, 
            icon: Icon(rightIcon , color: Theme.of(context).primaryColor),
            hoverColor: Colors.blue,
          ) , 
        ],

      leading: (!hasLeftIcon)? null :
      Builder(
        builder: (context) {
          return IconButton(
                onPressed: onLeftIconPressed ?? (){
                  Scaffold.of(context).openDrawer();
                }, 
                icon: Icon(leftIcon , color: Theme.of(context).primaryColor,),
              );
        }
      ) ,
    );
  }



import 'package:flutter/material.dart';
import 'package:recipe/models/routes.dart';

class IconInfo{
   
  IconData icon;
  String pathTo;
  

  IconInfo({
            required this.icon ,
            this.pathTo = ""
          });

  
}


final mapIcons = (
  menu : IconInfo(icon: Icons.menu ) ,
  home : IconInfo(icon: Icons.home_filled, pathTo: Routes.HOME.path ) ,
  settings : IconInfo(icon: Icons.settings, pathTo: Routes.SETTINGS.path ) ,
);



import 'package:flutter/material.dart';
import 'package:recipe/models/routes.dart';





enum MapIcons{

  MENU(icon: Icons.menu ) ,
  HOME(icon: Icons.home_filled , route: RoutePages.HOME ) ,
  SETTINGS(icon : Icons.settings , route: RoutePages.SETTINGS ) ;

  
  final IconData icon  ;
  final RoutePages? route ;

  String get path => route!.path ;

  const MapIcons({required this.icon , this.route});
}


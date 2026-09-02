




enum RoutePages {


  HOME(path:  "/home") , 
  SETTINGS(path:  "/settings") , 
  SHOW_RECIPES(path:  "/recipes/show") , 
  ADD_RECIPE(path:  "/recipes/add") , 
  ADD_SUPPLIES(path:  "/recipes/add/supplies") , 
  ADD_STEPS(path:  "/recipes/add/methods") ;

  final String path;

  const RoutePages({required this.path});
}
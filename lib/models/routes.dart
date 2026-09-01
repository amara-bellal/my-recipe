




enum Routes {


  HOME("/home") , 
  SETTINGS("/settings") , 
  SHOW_RECIPES("/recipes/show") , 
  ADD_RECIPE("/recipes/add") , 
  ADD_SUPPLIES("/recipes/add/supplies") , 
  ADD_METHODS("/recipes/add/methods") ;

  final String path;

  const Routes(String this.path);
}
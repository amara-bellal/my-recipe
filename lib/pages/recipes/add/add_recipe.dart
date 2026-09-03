



import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe/components/add%20recipe/name_image.dart';
import 'package:recipe/components/appbar.dart';
import 'package:recipe/models/state%20management/recipe.dart';

class AddRecipePage extends StatefulWidget{

  Recipe? recipe ;


  AddRecipePage({super.key , this.recipe}){

  }

  @override
  State<AddRecipePage> createState() => _AddRecipePage(recipe: recipe);
}









class _AddRecipePage extends State<AddRecipePage>{

  Recipe? recipe ;

// 1st Page
  TextEditingController nameController = TextEditingController();
  Uint8List? bytesImage ;

// 2nd Page
  List<String> supplies = [] ;


// 3rd Page
  List<String> steps = [] ;


  PageController pageController = new PageController(initialPage: 0);
  int _page = 0;

  _AddRecipePage({this.recipe});


  @override
  void initState() {
    nameController.text = recipe?.name ?? "";
    bytesImage = recipe?.image ; 
    super.initState();
  }






  Future<void> takeImage(ImageSource source) async{
    
    ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: source);
    final _bytesImage = await  image?.readAsBytes();
        

        setState(() {
          if(_bytesImage != null) {
            bytesImage = _bytesImage ;
          }
        });
  }


  void setSteps(List<String> steps){
    setState(() {
      this.steps = [ ...steps ] ; 
    });
  }

  void setSupplies(List<String> supplies){
    setState(() {
      this.supplies = [ ...supplies ] ; 
    });
  }





  Widget build(BuildContext context) {
    


    return Scaffold(

      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBarWidget(title: (recipe == null ? "وصفة جديدة" : "تعديل الوصفة"), context: context),

      body: PageView(

        onPageChanged: (value){
          setState(() {
            _page = value ;
          });
        },

        controller: pageController,
        scrollDirection: .horizontal,
        allowImplicitScrolling: true,

        children: [
          HeaderRecipe(bytesImage: bytesImage , nameController: nameController , setImage: takeImage ,) ,
        ],
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          mainAxisAlignment: .spaceBetween,
          crossAxisAlignment: .center,

          children: [
            Opacity( 
              opacity:  (_page != 0)? 1 : 0 ,
              child: FloatingActionButton(
                onPressed: (){
                  pageController.previousPage(duration: Duration(milliseconds: 500), curve: Curves.bounceOut);
                } ,
                child: Icon(Icons.arrow_back , color: Theme.of(context).primaryColor),
                
              )
            )
            ,
            FloatingActionButton(
              onPressed: null,
              child: Icon(Icons.save  , color: Theme.of(context).primaryColor,),
            )
            ,
            Opacity(
              opacity: (_page != 2)? 1 : 0 ,
              child: FloatingActionButton(
              onPressed: (){
                pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.bounceOut);
              } ,
              child: Icon(Icons.arrow_forward , color: Theme.of(context).primaryColor,),
              )
            )
          ],
        ),
      ),

      floatingActionButtonLocation: .centerFloat,
      floatingActionButtonAnimator: .noAnimation,
    );
    
  }
}
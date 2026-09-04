



import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe/components/add%20recipe/name_image.dart';
import 'package:recipe/components/add%20recipe/steps.dart';
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
  List<String> steps = ["امزج الحليب مع بيضتين" , "اخلط المزيج" , "ضعها في الفرن" , "انتظر 5 دقائق"] ;
  int? chosenField ;
  final TextEditingController editingController = TextEditingController() ;


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

  void modifyStep(int index , String step){
    setState(() {
      steps[index] = step ;
    });
  }

  void modifySupplie(int index , String supplie){
    setState(() {
      supplies[index] = supplie ;
    });
  }

  void swapTwoSteps(int index1 , int index2 ){
    setState(() {
      final step1 = steps[index1];
      final step2 = steps[index2];
      steps[index1] = step2 ;
      steps[index2] = step1 ;
    });
  }

  void removeStep(int index){
    setState(() {
      steps.removeAt(index);
    });
  }

  void removeSupplie(int index){
    setState(() {
      steps.removeAt(index);
    });
  }


  void leaveEditMode(){
    setState(() {
      chosenField = null ;
    });
  }

  void ChooseStepToEdit(int index){
    setState(() {
      editingController.text = steps[index];
      chosenField = index ;
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
        
        children: [
          HeaderRecipe(bytesImage: bytesImage , nameController: nameController , setImage: takeImage ,) ,
          AddStepsPage(steps: steps, modifyStep: modifyStep, swapSteps: swapTwoSteps, removeStep: removeStep,
                        chosenField: chosenField, editStep: ChooseStepToEdit, leaveEditMode: leaveEditMode,
                        EditStepController: editingController, )
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
                  pageController.previousPage(duration: Duration(milliseconds: 350), curve: Curves.easeOut);
                } ,
                child: Icon(Icons.arrow_back , color: Theme.of(context).primaryColor),
                
              )
            )
            ,
            FloatingActionButton(
              onPressed: (){},
              child: Icon(Icons.save  , color: Theme.of(context).primaryColor,),
            )
            ,
            Opacity(
              opacity: (_page != 2)? 1 : 0 ,
              child: FloatingActionButton(
              onPressed: (){
                pageController.nextPage(duration: Duration(milliseconds: 350), curve: Curves.easeOut);
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
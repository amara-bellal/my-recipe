



import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe/components/add%20recipe/name_image.dart';
import 'package:recipe/components/add%20recipe/steps.dart';
import 'package:recipe/components/add%20recipe/supplies.dart';
import 'package:recipe/components/appbar.dart';
import 'package:recipe/models/exceptions/exceptions.dart';
import 'package:recipe/models/state%20management/cubit_state.dart';
import 'package:recipe/models/state%20management/recipe.dart';






class RemoveConfirmationWidget extends StatelessWidget{

  final Function() remove ;

  const RemoveConfirmationWidget({super.key , required this.remove});


  @override
  Widget build(BuildContext context) {
    
    return AlertDialog(
      alignment: .center,
      actionsPadding: EdgeInsets.all(15),
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Text("تأكيد !" , style: TextStyle(color: Theme.of(context).primaryColor , fontWeight: .bold), textDirection: .rtl,),
      content: Text("هل أنت متأكد من أنك تريد حذفها" , style: TextStyle(color: Theme.of(context).primaryColor), textDirection: .rtl,),
      actionsAlignment: .start,
      actions: [
        MaterialButton(
          color: Theme.of(context).colorScheme.onSurface,
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text( "إلغاء" , style: TextStyle(color: Theme.of(context).primaryColor),),
        ),

        MaterialButton(
          color: Theme.of(context).colorScheme.onSurface,
          onPressed: (){
            Navigator.pop(context);
            remove();
          },
          child: Text( "تأكيد" , style: TextStyle(color: Theme.of(context).primaryColor),),
        ),

      ],
    );
    
  }

}










// ignore: must_be_immutable
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
  List<String> steps = [];
  int? chosenField ;
  final TextEditingController editingController = TextEditingController() ;


  PageController pageController = new PageController(initialPage: 0 );
  int _page = 0;
  final FocusNode focusnode = new FocusNode();

  _AddRecipePage({this.recipe});


  @override
  void initState() {
    if(recipe != null){
      steps = recipe!.steps ;
      supplies = recipe!.supplies ;
    }
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
      if(step == "") steps.removeAt(index);
      chosenField = null ;
    });
  }

  void modifySupplie(int index , String supplie){
    setState(() {
      supplies[index] = supplie ;
      if(supplie == "") supplies.removeAt(index);
      chosenField = null ;
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
      supplies.removeAt(index);
    });
  }

  void showAlertBoxToRemove(int index , Function(int) remove){
    showDialog(
      context: context, 
      builder: (context) => RemoveConfirmationWidget(remove: () => remove(index)),
    );
  }


  void addStepBetweenTwoSteps(int index){
    steps.insert(index, "");
    ChooseStepToEdit(index);
  }


  void ChooseStepToEdit(int index){
    setState(() {
      if(index >= steps.length) steps.add("");
      editingController.text = steps[index];
      chosenField = index ;
      focusnode.requestFocus();
    });
  }

   void ChooseSupplieToEdit(int index){
    setState(() {
      if(index >= supplies.length) supplies.add("");
      editingController.text = supplies[index];
      chosenField = index ;
      focusnode.requestFocus();
    });
  }



  void save() async{

    final String name = nameController.text ;

    print("name :  ${name}");
    print("......");
    print("steps :  $steps");
    print("......");
    print("supplies :  $supplies");

    try{

      if( name == "") throw MissingRecipeInformationsException(position: 0, message: "ضع اسم للوصفة");

      if(bytesImage == null) throw MissingRecipeInformationsException(position: 0, message: "ضع صورة للطبخة");

      if(supplies.length == 0) throw MissingRecipeInformationsException(position: 1, message: "أضف مكونا واحدا على الأقل للوصفة");
      
      if(steps.length == 0) throw MissingRecipeInformationsException(position: 2, message: "أضف خطوة واحدة على الأقل للوصفة");

    }on MissingRecipeInformationsException catch(e){
        Fluttertoast.showToast(
          msg: e.message ,
          backgroundColor: Colors.black ,
          textColor: Colors.white ,
          gravity: .BOTTOM ,
          fontSize: 15 ,
        );

        pageController.animateToPage(e.position, duration: Duration(milliseconds: 400), curve: Curves.easeOut);
        return ;
    }

    try{


      if(recipe == null){
        Recipe newRecipe = Recipe(name: name, image: bytesImage!, supplies: supplies, steps: steps);
        context.read<RecipeStateBloc>().addNewRecipe(newRecipe);
      }
      else{
        recipe!.name = name ;
        recipe!.image = bytesImage! ;
        recipe!.supplies = [...supplies] ;
        recipe!.steps = [...steps] ;
        context.read<RecipeStateBloc>().update(null);
      }


      Fluttertoast.showToast(
        msg: "تم حفظ الوصفة بنجاح" ,
        backgroundColor: Colors.black ,
        textColor: Colors.white ,
        gravity: .BOTTOM ,
        fontSize: 15 ,
      );

      Navigator.pop(context);

    }catch(e){

      Fluttertoast.showToast(
        msg: "حدث خطأ ما أثناء الحفظ" ,
        backgroundColor: Colors.black ,
        textColor: Colors.white ,
        gravity: .BOTTOM ,
        fontSize: 15 ,
      );

    }


  }




  Widget build(BuildContext context) {
    


    return Scaffold(

      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBarWidget(title: (recipe == null ? "وصفة جديدة" : "تعديل الوصفة"), context: context),

      body: PageView(
        physics: (chosenField != null)? NeverScrollableScrollPhysics() : null,

        onPageChanged: (value){
          setState(() {
            
              _page = value ;
            
            }
          );
        },

        

        controller: pageController,
        scrollDirection: .horizontal,

        children: [
          HeaderRecipe(bytesImage: bytesImage , nameController: nameController , setImage: takeImage ,) 
          ,

          AddSuppliesPage(supplies: supplies, modifySupplie: modifySupplie, removeSupplie: (index) => showAlertBoxToRemove(index, removeSupplie) ,
                        chosenField: chosenField, editSupplie: ChooseSupplieToEdit, editSupplieController: editingController,
                        focusnode: focusnode, )
          ,


          AddStepsPage(steps: steps, modifyStep: modifyStep, swapSteps: swapTwoSteps, removeStep: (index) => showAlertBoxToRemove(index, removeStep) ,
                        chosenField: chosenField, editStep: ChooseStepToEdit, editStepController: editingController,
                        focusnode: focusnode, addStepBetweenTwoSteps: addStepBetweenTwoSteps, )
          ,

        ],
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: (chosenField != null)? null :  Row(
            mainAxisAlignment: .spaceBetween,
            crossAxisAlignment: .center,
          
            children: [
              Opacity( 
                opacity:  (_page != 0)? 1 : 0 ,
                child: FloatingActionButton(
                  onPressed: (_page == 0)? null : (){
                    pageController.previousPage(duration: Duration(milliseconds: 350), curve: Curves.easeOut);
                  } ,
                  child: Icon(Icons.arrow_back , color: Theme.of(context).primaryColor),
                  
                )
              )
              ,
              FloatingActionButton(
                onPressed: save,
                child: Icon(Icons.save  , color: Theme.of(context).primaryColor,),
              )
              ,
              Opacity(
                opacity: (_page != 2)? 1 : 0 ,
                child: FloatingActionButton(
                onPressed:(_page == 2)? null : (){
                  pageController.nextPage(duration: Duration(milliseconds: 350), curve: Curves.easeOut);
                } ,
                child: Icon(Icons.arrow_forward , color: Theme.of(context).primaryColor,),
                )
              )
            ],
          ),
        ),

      floatingActionButtonLocation: .centerFloat,
      resizeToAvoidBottomInset : true,
      
    );
    
  }
}
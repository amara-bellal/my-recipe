



import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe/components/add%20recipe/name_image.dart';
import 'package:recipe/components/add%20recipe/steps.dart';
import 'package:recipe/components/appbar.dart';
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
  List<String> steps = ["ضع كأسين من الحليب","اضف كأسا من الطحين","احضر بيضتين","احضر الخلاط", "امزج الحليب مع بيضتين" , "اخلط المزيج" , "ضعها في الفرن" , "انتظر 5 دقائق"] ;
  int? chosenField ;
  final TextEditingController editingController = TextEditingController() ;


  PageController pageController = new PageController(initialPage: 0 );
  int _page = 0;
  final FocusNode focusnode = new FocusNode();

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
      if(step == "") steps.removeAt(index);
      chosenField = null ;
    });
  }

  void modifySupplie(int index , String supplie){
    setState(() {
      supplies[index] = supplie ;
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
      steps.removeAt(index);
    });
  }

  void showAlertBoxToRemove(int index , Function(int) remove){
    showDialog(
      context: context, 
      builder: (context) => RemoveConfirmationWidget(remove: () => remove(index)),
    );
  }



  void ChooseStepToEdit(int index){
    setState(() {
      if(index >= steps.length) steps.add("");
      editingController.text = steps[index];
      chosenField = index ;
      focusnode.requestFocus();
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
          HeaderRecipe(bytesImage: bytesImage , nameController: nameController , setImage: takeImage ,) 
          ,
          AddStepsPage(steps: steps, modifyStep: modifyStep, swapSteps: swapTwoSteps, removeStep: (index) => showAlertBoxToRemove(index, removeStep) ,
                        chosenField: chosenField, editStep: ChooseStepToEdit, editStepController: editingController,
                        focusnode: focusnode, )
          ,

        ],
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Opacity(
          opacity: (chosenField == null)? 1 : 0,
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
      ),

      floatingActionButtonLocation: .centerFloat,
      resizeToAvoidBottomInset : true,
    );
    
  }
}



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/components/LoadingCircle.dart';
import 'package:recipe/components/RecipeCard.dart';
import 'package:recipe/components/appbar.dart';
import 'package:recipe/components/emptyPage.dart';
import 'package:recipe/components/setting/drawer_setting.dart';
import 'package:recipe/models/state%20management/cubit_state.dart';
import 'package:recipe/models/state%20management/recipe.dart';



enum SortMode{
  FAVORABLE , DATE , NAME
}




class ListRecipes extends StatefulWidget{

   ListRecipes({super.key});

  @override
  State<ListRecipes> createState() => _ListRecipes();

}





class _ListRecipes extends State<ListRecipes>{


  SortMode _sortmode = .FAVORABLE ;
  bool _inverseSort = false ;

  @override
  void initState() {
    setState(() {
      
    });
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    
    context.read<RecipeStateBloc>().leaveRecipes() ;
    print("start");
    context.read<RecipeStateBloc>().getRecipes() ;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      
      appBar: AppBarWidget(title: "وصفاتي", context: context , hasLeftIcon: true ),

      drawer: SettingsDrawer(),
      
      body: Column(
        children: [
          
          Container(
            
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inverseSurface, 
              
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(100) ,
                  offset: Offset(0, 5) ,
                  blurRadius: 2.0 , 
                ),
              ]
            ),

            padding: EdgeInsets.all(15.0),
            child: Row(
              textDirection: .rtl,
              mainAxisAlignment: .spaceBetween,
              children: [
                
                Text(": ترتيب الوصفات على حسب" , 
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary ,
                    fontSize: 16,
                    fontWeight: .bold
                  ),
                ),

                
                Row(

                  spacing: 5,
                  children: [

                     DropdownButton<bool>(
                      underline: Opacity(opacity: 0),
                      value: _inverseSort,
                      alignment: .centerRight,
                      dropdownColor: Theme.of(context).colorScheme.inversePrimary,
                      borderRadius: BorderRadius.circular(10),
                      focusColor: Theme.of(context).colorScheme.inverseSurface,
                      style: TextStyle(color: Theme.of(context).colorScheme.primary , fontSize: 15 , fontWeight: .bold),
                      icon: Icon(Icons.arrow_drop_down_rounded , color: Theme.of(context).colorScheme.primary,),
                      iconDisabledColor: Theme.of(context).colorScheme.onSecondary,

                      items: [
                        DropdownMenuItem(child: Text("تصاعديا") , value: false ),
                        DropdownMenuItem(child: Text("تنازليا") , value: true),
                      ], 
                      onChanged:(_sortmode == .FAVORABLE)? null: (value){
                        setState(() {
                          if(value == null) return ;
                          _inverseSort = value ;
                        });
                      }
                      ),


                    DropdownButton<SortMode>(
                      value: _sortmode,
                      alignment: .centerRight,
                      underline: Opacity(opacity: 0),
                      dropdownColor: Theme.of(context).colorScheme.inversePrimary,
                      borderRadius: BorderRadius.circular(10),
                      style: TextStyle(color: Theme.of(context).colorScheme.primary , fontSize: 15 , fontWeight: .bold , fontFamily: "Rubic"),
                      icon: Icon(Icons.arrow_drop_down_rounded , color: Theme.of(context).colorScheme.primary,),
                      items: [
                        DropdownMenuItem(child: Text("التاريخ") , value: .DATE),
                        DropdownMenuItem(child: Text("المفضلة") , value: .FAVORABLE,),
                        DropdownMenuItem(child: Text("الاسم") , value: .NAME,),
                      ], 
                      onChanged: (value){
                        setState(() {
                          if(value == null) return ;
                          _sortmode = value ;
                          if(value == .FAVORABLE) _inverseSort = false;
                        });
                      }
                      ),

                   
                  ],
                )


              ],
            ),
          )
          ,
          Expanded(
            child: BlocBuilder<RecipeStateBloc , List<Recipe>?>(
                builder: (context , state){
                  print("$state in blocbuilder");
                  if(state == null) return LoadingCircle();
                  
                  if(state.length == 0) return Nothing(text: "لا توجد اي وصفة");
            
                  state.sort((r1 , r2){
                    switch(_sortmode){
                      case .FAVORABLE :
                        return r1.compareTo(r2);
                      case .NAME :
                        return r1.name.compareTo(r2.name);
                      case .DATE :
                        return r1.dateCreated.compareTo(r2.dateCreated);
                    }
                  });

                  if(_inverseSort) state = state.reversed.toList();
                  
                  return ListView.separated(
                    itemCount: state.length ,
            
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0 , vertical: 20),
                      child: Divider(color: Theme.of(context).colorScheme.surface , radius: BorderRadius.circular(10) ,),
                    ),
            
                    itemBuilder: (context , index){
                      final recipe = state![index];
                      return RecipeCard(recipe: recipe);
                    }
                    );
                } 
              ),
          ),
        ],
      ),
    );
    
  }

}
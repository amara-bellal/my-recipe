





import 'dart:typed_data';

class Recipe {


  String name;
  Uint8List image ;
  List<String> supplies ;
  List<String> steps ;

  bool isFavorable = false ;
  bool isShared = false;
  
  late DateTime dateCreated ;

  Recipe({required this.name , required this.image , required this.supplies , 
        required this.steps , DateTime? dateCreated}){
          this.dateCreated = dateCreated ?? DateTime.now();
        }

  factory Recipe.fromMap(Map<String , dynamic> map){

    String name = map["name"] as String ;
    Uint8List image = map["image"] as Uint8List ;
    List<String> supplies = map["supplies"] as List<String> ;
    List<String> steps = map["steps"] as List<String> ;
    bool favorable = map["favorable"] as bool ;
    bool shared = map["shared"] as bool  ;
    DateTime date = map["date"] as DateTime ;

    Recipe recipe = new Recipe(name: name, image: image, supplies: supplies, steps: steps , dateCreated: date);

    recipe.isFavorable = favorable ;
    recipe.isShared = shared ;

    return recipe ;

  }


  Map<String , dynamic> toMap(){
    return <String, dynamic>{
      "name"      : name ,
      "image"     : image ,
      "supplies"  : supplies ,
      "steps"     : steps ,
      "favorable" : isFavorable ,
      "shared"    : isShared ,
      "date"      : dateCreated ,
    } ;
  }

  void setImage(Uint8List bytes){
    image = bytes ;
  }


  void addStep(String step , int? index){
    if(index == null){
      steps.add(step);
    }
    else{
      steps.insert(index, step);
    }
  }


  void addSupplie(String supplie){
    supplies.add(supplie);
  }


  void modifyStep(String step , int index){
    steps[index] = step ;
  }

  void modifySupplie(String supplie , int index){
    supplies[index] = supplie ;
  }

  void removeStep(int index){
    steps.removeAt(index);
  }

  void removeSupplie(int index){
    supplies.removeAt(index);
  }

  

}
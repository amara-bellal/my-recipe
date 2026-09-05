

class MissingRecipeInformationsException implements Exception {

    final int position ;
    final String message;

    const MissingRecipeInformationsException({required this.position , required this.message});
}
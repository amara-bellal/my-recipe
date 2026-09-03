

class MissingRecipeInformationsException implements Exception {

    final int position ;

    const MissingRecipeInformationsException({required this.position});
}
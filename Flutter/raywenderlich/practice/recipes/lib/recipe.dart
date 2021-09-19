import 'Ingredient.dart';

class Recipe {
  Recipe(this.label, this.imageUrl, this.servings, this.ingredients);

  String label;
  String imageUrl;
  List<Ingredient> ingredients;
  int servings;
}
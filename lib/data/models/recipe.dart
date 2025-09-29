class Recipe {
  final String idMeal;
  final String Meal;
  final String Category;
  final String Area;
  final String Instructions;
  final String MealThumb;
  final List<String> ingredientsAndMeasures;
  final bool isFavorite;

  Recipe({
    required this.idMeal,
    required this.Meal,
    required this.Category,
    required this.Area,
    required this.Instructions,
    required this.MealThumb,
    required this.ingredientsAndMeasures,
    this.isFavorite = false,
  });

  factory Recipe.fromJson(Map<String, dynamic> json){
    List<String> ingredients = [];
    for(int i = 1; i <= 20; i++){
      final ingredient = json['Ingredient$i'];
      final measure = json['Measure$i'];

      if (ingredient != null){
        ingredients.add('${measure?.trim() ?? ''} - ${ingredient.trim()}');
      }
    }

    return Recipe(
            idMeal: json['idMeal'] ?? '',
      Meal: json['Meal'] ?? 'Receita Desconhecida',
      Category: json['Category'] ?? '',
      Area: json['Area'] ?? '',
      Instructions: json['Instructions'] ?? '',
      MealThumb: json['MealThumb'] ?? '',
      ingredientsAndMeasures: ingredients,
      isFavorite: false,
    );
  }

Recipe copyWith({
    bool? isFavorite,
  }) {
    return Recipe(
      idMeal: idMeal,
      Meal: Meal,
      Category: Category,
      Area: Area,
      Instructions: Instructions,
      MealThumb: MealThumb,
      ingredientsAndMeasures: ingredientsAndMeasures,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
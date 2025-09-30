class Recipe {
  final String idMeal;
  final String strMeal;
  final String strCategory;
  final String strArea;
  final String strInstructions;
  final String strMealThumb;
  final List<String> ingredientsAndMeasures;
  final bool isFavorite;

  Recipe({
    required this.idMeal,
    required this.strMeal,
    required this.strCategory,
    required this.strArea,
    required this.strInstructions,
    required this.strMealThumb,
    required this.ingredientsAndMeasures,
    this.isFavorite = false,
  });

  factory Recipe.fromJson(Map<String, dynamic> json){
    List<String> ingredients = [];
    for(int i = 1; i <= 20; i++){
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];

      if (ingredient != null && (ingredient as String).trim().isNotEmpty){
        final measureStr = (measure is String) ? measure.trim() : '';
        ingredients.add('${measureStr.isNotEmpty ? measureStr : ''}${measureStr.isNotEmpty ? ' - ' : ''}${(ingredient).trim()}');
      }
    }

    return Recipe(
      idMeal: json['idMeal'] ?? '',
      strMeal: json['strMeal'] ?? 'Receita Desconhecida',
      strCategory: json['strCategory'] ?? '',
      strArea: json['strArea'] ?? '',
      strInstructions: json['strInstructions'] ?? '',
      strMealThumb: json['strMealThumb'] ?? '',
      ingredientsAndMeasures: ingredients,
      isFavorite: false,
    );
  }

Recipe copyWith({
    bool? isFavorite,
  }) {
    return Recipe(
      idMeal: idMeal,
      strMeal: strMeal,
      strCategory: strCategory,
      strArea: strArea,
      strInstructions: strInstructions,
      strMealThumb: strMealThumb,
      ingredientsAndMeasures: ingredientsAndMeasures,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
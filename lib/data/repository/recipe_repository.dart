
import 'package:cookly/data/models/recipe.dart';
import 'package:cookly/data/services/api_service.dart';

class RecipeRepository {

  late final ApiService _apiService;

  RecipeRepository({required ApiService apiService}) : _apiService = apiService;

  Future<List<Recipe>> fetchInitialRecipes() async {
    final List<Map<String, dynamic>>? mealsJsonList = await _apiService.searchMeals('chicken');

    if(mealsJsonList == null || mealsJsonList.isEmpty){
      return [];
    }

    return mealsJsonList.map((json) => Recipe.fromJson(json)).toList();
  }

  Future<Recipe?> fetchRecipeDetails(String idMeal) async {
    final Map<String, dynamic> responseData = await _apiService.fetchMealDetails(idMeal);

    final List<dynamic>? mealsList = responseData['meals'];

    if(mealsList != null && mealsList.isNotEmpty){
      return Recipe.fromJson(mealsList.first as Map<String, dynamic>);
    }
    return null;
  }
}
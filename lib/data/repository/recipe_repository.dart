
import 'dart:convert';

import 'package:cookly/data/models/recipe.dart';
import 'package:cookly/data/services/api_service.dart';

class RecipeRepository {

  late final ApiService _apiService;

  RecipeRepository({required ApiService apiService}) : _apiService = apiService;

  Future<List<Recipe>> fetchInitialRecipes() async {
    final List<Map<String, dynamic>>? MealsJsonList = 
    await _apiService.searchMealsByLetter('b');

    if(MealsJsonList == null || MealsJsonList.isEmpty){
      return [];
    }

    return MealsJsonList.map((json) => Recipe.fromJson(json)).toList();
  }

  Future<Recipe?> fetchRecipeDetails(String idMeal) async {
    final Map<String, dynamic> responseData = await _apiService.fetchMealDetails(idMeal);

    final List<dynamic>? strMealsList = responseData['strMeals'];

    if(strMealsList != null && strMealsList.isNotEmpty){
      return Recipe.fromJson(strMealsList.first as Map<String, dynamic>);
    }
    return null;
  }

  Future <List<Recipe>> searchRecipes(String query) async {
    final List<Map<String, dynamic>>? MealsJsonList =
    await _apiService.searchMeals(query);

    if(MealsJsonList == null || MealsJsonList.isEmpty) {
      return [];
    }

    return MealsJsonList.map((json) => Recipe.fromJson(json)).toList();
  }
}
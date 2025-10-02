
import 'dart:convert';

import 'package:cookly/data/models/category.dart';
import 'package:cookly/data/models/recipe.dart';
import 'package:cookly/data/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _kFavoritesKey = 'favorite_recipe_ids';

class RecipeRepository {

  late final ApiService _apiService;

  RecipeRepository({required ApiService apiService}) : _apiService = apiService;

    Future<List<String>> _loadFavoriteIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_kFavoritesKey) ?? [];
  }

  
  @override
  Future<void> toggleFavorite(String idMeal, bool isCurrentlyFavorite) async {
    List<String> favorites = await _loadFavoriteIds();

    if (isCurrentlyFavorite) {
      if (!favorites.contains(idMeal)) {
        favorites.add(idMeal);
      }
    } else {
      favorites.remove(idMeal);
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_kFavoritesKey, favorites);
  }

  Future<bool> isRecipeFavorite(String idMeal) async {
    final favorites = await _loadFavoriteIds();
    return favorites.contains(idMeal);
  }

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

    List<Recipe> recipes = MealsJsonList.map((json) => Recipe.fromJson(json)).toList();

    return _enrichRecipesWithFavorites(recipes);
  }

  Future<List<MealCategory>> fetchCategories() async {
    final List<Map<String, dynamic>>? CategoriesJsonList =
    await _apiService.fetchCategories();

    if(CategoriesJsonList == null || CategoriesJsonList.isEmpty) {
      return [];
    }

    return CategoriesJsonList.map((json) => MealCategory.fromJson(json)).toList();
  }
  @override
  Future<List<Recipe>> fetchRecipesByCategory(String categoryName) async {
    final List<Map<String, dynamic>>? mealsJsonList =
    await _apiService.searchMeals(categoryName);

    if(mealsJsonList == null || mealsJsonList.isEmpty) {
      return [];
    }

    List<Recipe> recipes = mealsJsonList.map((json) => Recipe.fromJson(json)).toList();

    return _enrichRecipesWithFavorites(recipes);
  }

    Future<List<Recipe>> _enrichRecipesWithFavorites(List<Recipe> recipes) async {
    final favoriteIds = await _loadFavoriteIds();
    
    return recipes.map((recipe) {
      final isFav = favoriteIds.contains(recipe.idMeal);
      return recipe.copyWith(isFavorite: isFav);
    }).toList();
  }
}
import 'package:flutter/foundation.dart';
import '../../data/repository/recipe_repository.dart';
import '../../data/models/recipe.dart';
import '../../data/models/category.dart';
import '../../core/constants.dart';

enum ViewState { loading, loaded, error }

class HomeViewModel extends ChangeNotifier {
  final RecipeRepository _repository;
  
  ViewState _state = ViewState.loading;
  String _errorMessage = '';

  List<Recipe> _recipes = [];
  List<MealCategory> _categories = [];
  String? _selectedCategoryName; 

  HomeViewModel({required RecipeRepository repository}) : _repository = repository {
    loadInitialData();
  }

  ViewState get state => _state;
  List<Recipe> get recipes => _recipes;
  List<MealCategory> get categories => _categories;
  String? get selectedCategoryName => _selectedCategoryName;
  String get errorMessage => _errorMessage;

  Future<void> loadInitialData() async {
    _setState(ViewState.loading);
    try {
      final fetchedCategories = await _repository.fetchCategories();
      _categories = fetchedCategories;
      
      if (_categories.isNotEmpty) {
        _selectedCategoryName = _categories.first.strCategory;
      }
      
      await fetchRecipes(); 

    } catch (e) {
      _errorMessage = 'Falha ao carregar dados iniciais e categorias: ${e.toString()}';
      _setState(ViewState.error);
      if (kDebugMode) {
        print('Erro ao carregar dados iniciais: $e');
      }
    }
  }


  Future<void> fetchRecipes() async {
    _setState(ViewState.loading);
    
    final query = _selectedCategoryName ?? 'Chicken'; 

    try {
      final fetchedRecipes = await _repository.fetchRecipesByCategory(query); 
      
      _recipes = fetchedRecipes;
      
      if (_recipes.isEmpty) {
        _errorMessage = AppConstants.noDataMessage;
        _setState(ViewState.error);
      } else {
        _setState(ViewState.loaded);
      }

    } catch (e) {
      _errorMessage = 'Falha ao carregar receitas para $query: ${e.toString()}';
      _setState(ViewState.error);
      if (kDebugMode) {
        print('Erro no ViewModel ao buscar receitas: $e');
      }
    }
  }

  Future<void> selectCategory(String categoryName) async {
    if (categoryName == _selectedCategoryName) {
      return;
    }
    
    _selectedCategoryName = categoryName;
    notifyListeners(); 
    
    await fetchRecipes();
  }
  

  void toggleFavoriteStatus(String idMeal) {
    final recipeIndex = _recipes.indexWhere((r) => r.idMeal == idMeal);
    
    if (recipeIndex != -1) {
      final currentRecipe = _recipes[recipeIndex];
      final newFavoriteStatus = !currentRecipe.isFavorite;

      _repository.toggleFavorite(idMeal, newFavoriteStatus);
      
      _recipes[recipeIndex] = currentRecipe.copyWith(isFavorite: newFavoriteStatus);
      
      notifyListeners();
    }
  }

  void _setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }
}
import 'package:cookly/core/constants.dart';
import 'package:cookly/data/models/recipe.dart';
import 'package:cookly/data/repository/recipe_repository.dart';
import 'package:flutter/foundation.dart';

enum ViewState { loading, loaded, error}

class HomeViewmodel extends ChangeNotifier{

  late final RecipeRepository _repository;

  ViewState _state = ViewState.loading;
  List<Recipe> _recipes = [];
  String _errorMessage = '';

  HomeViewmodel({required RecipeRepository repository}) : _repository = repository {
    fetchRecipes();
  }

  ViewState get state => _state;
  List<Recipe> get recipes => _recipes;
  String get errorMessage => _errorMessage;

  Future<void> fetchRecipes() async {
    _setState(ViewState.loading);

    try{
      final fetchRecipes = await _repository.fetchInitialRecipes();

      _recipes = fetchRecipes;

      if(_recipes.isEmpty){
        _errorMessage = AppConstants.noDataMessage;
        _setState(ViewState.error);
      }else{
        _setState(ViewState.loaded);
      }
    }catch(e){
      _errorMessage = 'Falha ao carregar receitas: ${e.toString()}';
      _setState(ViewState.error);
      if(kDebugMode){
        print('Erro no viewmodel: $e');
      }
    }
  }

  void toggleFavoriteStatus(String idMeal) {
    final recipeIndex = _recipes.indexWhere((r) => r.idMeal == idMeal);

    if(recipeIndex != -1){
      final currentRecipe = _recipes[recipeIndex];
      final newFavoriteStatus = !currentRecipe.isFavorite;

      _recipes[recipeIndex] = currentRecipe.copyWith(isFavorite: newFavoriteStatus);

      notifyListeners();
    }
  }

  void _setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }
}
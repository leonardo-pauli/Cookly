import 'package:cookly/data/models/recipe.dart';
import 'package:cookly/data/repository/recipe_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum DetailViewState { loading, loaded, error}

class DetailViewModel extends ChangeNotifier {
  late final RecipeRepository _repository;

  DetailViewState _state = DetailViewState.loading;
  Recipe? _recipe;
  String _errorMessage = '';

  DetailViewModel({required RecipeRepository repository}) : _repository = repository;

  DetailViewState get state => _state;
  Recipe? get recipe => _recipe;
  String? get errorMessage => _errorMessage;

  Future<void> loadRecipeDetails(String idMeal) async {
    _setState(DetailViewState.loading);

    try{
      final fetchedRecipe = await _repository.fetchRecipeDetails(idMeal);

      _recipe = fetchedRecipe;

      if(_recipe == null){
        _errorMessage = 'Detalhes da receita não encontrados.';
        _setState(DetailViewState.error);
      }else{
        _setState(DetailViewState.loaded);
      }
    }catch(e){
      _errorMessage = 'Falha ao carregar detalhes: ${e.toString()}';
      _setState(DetailViewState.error);
      if(kDebugMode){
        print('Erro no DetailViewModel: $e');
      }
    }
  }

  void toggleFavoriteStatus(String idMeal) {
    if(_recipe == null) return;

    final newFavoriteStatus = !_recipe!.isFavorite;

    _repository.toggleFavorite(idMeal, newFavoriteStatus);

    _recipe = _recipe!.copyWith(isFavorite: newFavoriteStatus);

    notifyListeners();
  }

  void _setState(DetailViewState newState){
    _state = newState;
    notifyListeners();
  }
  
}
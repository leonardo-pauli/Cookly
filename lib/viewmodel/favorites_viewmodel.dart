import 'package:cookly/data/models/recipe.dart';
import 'package:cookly/data/repository/recipe_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum FavoriteViewState { loading, loaded, empty, error, initial }

class FavoritesViewmodel extends ChangeNotifier {
 final RecipeRepository _repository;

  FavoriteViewState _state = FavoriteViewState.loading;
  List<Recipe> _favoriteRecipes = [];
  String _errorMessage = '';

  FavoritesViewmodel({required RecipeRepository repository})
    : _repository = repository {
    loadFavoriteRecipes();
  }

  FavoriteViewState get state => _state;
  List<Recipe> get favoriteRecipes => _favoriteRecipes;
  String get errorMessage => _errorMessage;

  Future<void> loadFavoriteRecipes() async {
    _setState(FavoriteViewState.loading);
    _favoriteRecipes = [];

    try {
      final fetchedFavorites = await _repository.fetchFavoriteRecipesDetails(); 
      _favoriteRecipes = fetchedFavorites;
      // NOTA: O Repositório precisa de um novo método para buscar FAVORITOS.
      // Vamos assumir que ele terá um: _repository.fetchFavoritesDetails()

      // Por enquanto, vou simular um carregamento vazio para testar o 'empty state'
      // O Repositório precisa ser ajustado para devolver a lista correta!

      // >>> CÓDIGO TEMPORÁRIO PARA NÃO QUEBRAR A ESTRUTURA <<<
      // final fetchedFavorites = await _repository.fetchFavoriteRecipesDetails();
      // _favoriteRecipes = fetchedFavorites;

      // >>> CÓDIGO PERMANENTE (após ajuste no Repositório) <<<
      // Para funcionar agora, vamos carregar uma lista de exemplo (ou vazio):

      if (_favoriteRecipes.isEmpty) {
        // Se a lista estiver vazia
        _setState(FavoriteViewState.empty);
      } else {
        _setState(FavoriteViewState.loaded);
      }
    } catch (e) {
      _errorMessage = 'Falha ao carregar favoritos: ${e.toString()}';
      _setState(FavoriteViewState.error);
      if (kDebugMode) {
        print("Erro no FavoritesViewModel: $e");
      }
    }
  }

  Future<void> toggleFavoriteStatus(String idMeal) async {
    final recipeIndex = _favoriteRecipes.indexWhere((r) => r.idMeal == idMeal );

    if(recipeIndex != -1){
      final currentRecipe = _favoriteRecipes[recipeIndex];
      final newFavoriteStatus = !currentRecipe.isFavorite;

      await _repository.toggleFavorite(idMeal, newFavoriteStatus);

      await loadFavoriteRecipes();
    }
  }

  void _setState(FavoriteViewState newState) {
    _state = newState;
    notifyListeners();
  }
}

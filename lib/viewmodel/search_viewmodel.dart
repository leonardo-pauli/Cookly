import 'package:cookly/data/models/recipe.dart';
import 'package:cookly/data/repository/recipe_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum SearchViewState { initial, loading, loaded, error }

class SearchViewModel extends ChangeNotifier{
  late final RecipeRepository _repository;

  SearchViewState _state = SearchViewState.initial;
  List<Recipe> _searchResults = [];
  String _errorMessage = '';
  String _currentQuery = '';

  SearchViewModel ({ required RecipeRepository repository}) : _repository = repository;

  SearchViewState get state => _state;
  List<Recipe> get searchResults => _searchResults;
  String get errorMessage => _errorMessage;

  Future<void> searchMeals (String query) async {
    final trimmedQuery = query.trim();
    if(trimmedQuery.isEmpty){
      _searchResults = [];
      _currentQuery = '';
      _setState(SearchViewState.initial);
      return;
    }

    if(trimmedQuery == _currentQuery && _state == SearchViewState.loaded){
      return;
    }

    _currentQuery = trimmedQuery;
    _setState(SearchViewState.loading);

    try{
      final fetchedRecipes = await _repository.searchRecipes(trimmedQuery);

      _searchResults = fetchedRecipes;

      if(_searchResults.isEmpty){
        _errorMessage = 'Nenhuma receita encontrada para "$trimmedQuery".';
        _setState(SearchViewState.error);
      }else{
        _setState(SearchViewState.loaded);
      }
    }catch(e){
      _errorMessage = 'Falha ao buscar receitas : ${e.toString()}';
      _setState(SearchViewState.error);
      if(kDebugMode){
        print('Erro no SearchViewModel: $e');
      }
    }
 }

 void _setState(SearchViewState newState){
  _state = newState;
  notifyListeners();
 }
}
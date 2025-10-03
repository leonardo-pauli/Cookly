import 'package:cookly/core/constants.dart';
import 'package:cookly/view/widgets/loading.dart';
import 'package:cookly/view/widgets/recipe_card.dart';
import 'package:cookly/viewmodel/search_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Esta tela será implementada com a lógica do SearchViewModel depois.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(AppConstants.searchTitle),
        centerTitle: false,
      ),
      body: Consumer<SearchViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: [
              SizedBox(height: AppConstants.paddingMedium),
              _buildSeachBar(context, viewModel),

              Expanded(child: _buildBodyContent(context, viewModel)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSeachBar(BuildContext context, SearchViewModel viewModel) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: EdgeInsets.all(AppConstants.paddingMedium),
      child: TextField(
        autofocus: false,
        decoration: InputDecoration(
          hintText: 'Buscar por nome da receita...',
          prefixIcon: Icon(Icons.search, color: primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            borderSide: BorderSide(color: primaryColor, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        ),
        onSubmitted: (query) {
          viewModel.searchMeals(query);
        },
      ),
    );
  }

  Widget _buildBodyContent(BuildContext context, SearchViewModel viewModel) {
    if (viewModel.state == SearchViewState.initial) {
      return Center(
        child: Text(
          'Digite um nome de receita para começar a busca!',
          textAlign: TextAlign.center,
        ),
      );
    }

    if (viewModel.state == SearchViewState.loading) {
      return const LoadingWidget();
    }

    if (viewModel.state == SearchViewState.error ||
        viewModel.searchResults.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(AppConstants.paddingLarge),
          child: Text(
            viewModel.errorMessage,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.all(AppConstants.paddingMedium),
      itemCount: viewModel.searchResults.length,
      itemBuilder: (context, index) {
        final recipe = viewModel.searchResults[index];
        return RecipeCard(
          recipe: recipe,
          onToggleFavorite: () {
            print('Favorito clicado na busca: ${recipe.idMeal}');
          },
        );
      },
    );
  }
}

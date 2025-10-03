import 'package:cookly/view/widgets/loading.dart';
import 'package:cookly/view/widgets/recipe_card.dart';
import 'package:cookly/viewmodel/favorites_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(AppConstants.favoritesTitle),
        centerTitle: false,
      ),
      body: Consumer<FavoritesViewmodel>(
        builder: (context, viewModel, child) {
          return RefreshIndicator(
            child: _buildContent(context, viewModel),
            onRefresh: viewModel.loadFavoriteRecipes,
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, FavoritesViewmodel viewModel) {
    switch (viewModel.state) {
      case FavoriteViewState.loading:
      case FavoriteViewState.initial:
        return const LoadingWidget();

      case FavoriteViewState.empty:
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite_border, size: 60, color: Colors.grey),
              SizedBox(height: AppConstants.paddingMedium),
              Text(
                'Você ainda não tem receitas favoritas!',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: AppConstants.paddingSmall),
              Text(
                'Toque no coração para salvar uma!',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        );

      case FavoriteViewState.error:
        return Center(
          child: Padding(
            padding: EdgeInsets.all(AppConstants.paddingMedium),
            child: Text(
              viewModel.errorMessage,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        );

      case FavoriteViewState.loaded:
        return ListView.builder(
          padding: EdgeInsets.all(AppConstants.paddingMedium),
          itemCount: viewModel.favoriteRecipes.length,
          itemBuilder: (context, index) {
            final recipe = viewModel.favoriteRecipes[index];

            return RecipeCard(
              recipe: recipe,
              onToggleFavorite: () async {
                await viewModel.toggleFavoriteStatus(recipe.idMeal);
              }
            );
          },
        );
    }
  }
}

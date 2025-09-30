import 'package:cookly/core/constants.dart';
import 'package:cookly/view/widgets/loading.dart';
import 'package:cookly/view/widgets/recipe_card.dart';
import 'package:cookly/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.homeTitle),
        centerTitle: false,

        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.favorite))],
      ),
      body: Consumer<HomeViewmodel>(
        builder: (context, viewModel, child) {
          if (viewModel.state == ViewState.loading) {
            return LoadingWidget();
          }
          if (viewModel.state == ViewState.error || viewModel.recipes.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(AppConstants.paddingLarge),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      size: 60,
                      color: Colors.orange,
                    ),
                    SizedBox(height: AppConstants.paddingMedium),
                    Text(
                      viewModel.errorMessage.isNotEmpty
                          ? viewModel.errorMessage
                          : AppConstants.noDataMessage,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: AppConstants.paddingMedium),
                    ElevatedButton.icon(
                      onPressed: viewModel.fetchRecipes,
                      icon: Icon(Icons.refresh),
                      label: Text('Tentar Novamente'),
                    ),
                  ],
                ),
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.all(AppConstants.paddingMedium),
            itemCount: viewModel.recipes.length,
            itemBuilder: (context, index) {
              final recipe = viewModel.recipes[index];
              return RecipeCard(
                recipe: recipe,
                onToggleFavorite: () {
                  viewModel.toggleFavoriteStatus(recipe.idMeal);
                },
              );
            },
          );
        },
      ),
    );
  }
}

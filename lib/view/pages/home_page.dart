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
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(AppConstants.homeTitle),
        centerTitle: false,
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {

          if (viewModel.state == ViewState.loading) {
            return LoadingWidget();
          }

          if (viewModel.state == ViewState.error || viewModel.recipes.isEmpty) {

            return _buildErrorState(context, viewModel);

          }

          return Column(
            children: [
              _buildCategoryFilter(context, viewModel),
              Expanded(
                child: ListView.builder(
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
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

Widget _buildCategoryFilter(BuildContext context, HomeViewModel viewModel){
  final theme = Theme.of(context);
  final primaryColor = theme.colorScheme.primary;

  if(viewModel.categories.isEmpty){
    return const SizedBox.shrink();
  }

  return Container(
    height: 50,
    padding: const EdgeInsets.symmetric(vertical: AppConstants.paddingSmall),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: viewModel.categories.length,
      itemBuilder: (context, index){
        final category = viewModel.categories[index];
        final isSelected = category.strCategory == viewModel.selectedCategoryName;

        return Padding(
          padding: EdgeInsets.only(left: AppConstants.paddingSmall),
          child: ChoiceChip(
            label: Text(category.strCategory), 
            selected: isSelected,
            selectedColor: primaryColor,

            labelStyle: theme.textTheme.labelLarge?.copyWith(
              color: isSelected
              ? Colors.white
              : theme.colorScheme.onSurface,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
            backgroundColor: theme.colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: isSelected ? primaryColor : theme.colorScheme.outline,
              ),
            ),
            onSelected: (_) {
              viewModel.selectCategory(category.strCategory);
            },
            ),
          );
      },
    ),
  );

}

Widget _buildErrorState(BuildContext context, HomeViewModel viewModel){
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
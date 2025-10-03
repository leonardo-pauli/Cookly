import 'package:cookly/core/app_routes.dart';
import 'package:cookly/core/constants.dart';
import 'package:cookly/data/models/recipe.dart';
import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onToggleFavorite;

  const RecipeCard({
    super.key,
    required this.recipe,
    required this.onToggleFavorite
  });

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingMedium),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            AppRoutes.recipeDetail,
            arguments: recipe.idMeal,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRecipeImage(context, primaryColor),

            Padding(padding: EdgeInsets.all(AppConstants.paddingSmall),
            child: Row(
              children: [
                Expanded(child: Text(
                  recipe.strMeal,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                ),

                IconButton(
                  onPressed: onToggleFavorite, 
                  icon: Icon(recipe.isFavorite ? Icons.favorite : Icons.favorite_border,),
                  color: primaryColor,
                  )
              ],
            ),
            ),

            Padding(padding: EdgeInsets.only(
              left: AppConstants.paddingSmall,
              bottom: AppConstants.paddingSmall),
              child: Text(
                'Categoria: ${recipe.strCategory}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              ),
          ],
        ),
      ),
    );
  }
  // Widget auxiliar para construir a imagem com borda arredondada
  Widget _buildRecipeImage(BuildContext context, Color primaryColor) {
    return Container(
      height: 200, 
      width: double.infinity,
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.1), 
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppConstants.borderRadius)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppConstants.borderRadius)),
        child: Image.network(
          recipe.strMealThumb,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                    : null,
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return const Center(child: Icon(Icons.broken_image, size: 50));
          },
        ),
      ),
    );
  }
}
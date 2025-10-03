import 'package:cookly/core/constants.dart';
import 'package:cookly/view/widgets/loading.dart';
import 'package:cookly/viewmodel/detail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final String recipeId;

  const DetailPage({super.key, required this.recipeId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<DetailViewModel>(context, listen: false);
      viewModel.loadRecipeDetails(widget.recipeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailViewModel>(
      builder: (context, viewModel, child ){
        if(viewModel.state == DetailViewState.loading){
          return const Scaffold(body: LoadingWidget(),);
        }

        if(viewModel.state == DetailViewState.error || viewModel.recipe == null){
          return Scaffold(
            appBar: AppBar(
              title: Text('Erro'),
            ),
            body: Center(
              child: Text( 'Erro ao carregar detalhes.'
              ),
            ),
          );
        }

        final recipe = viewModel.recipe!;
        final primaryColor = Theme.of(context).colorScheme.primary;

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 250,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(recipe.strMeal,
                  style: TextStyle(color: primaryColor, shadows: [Shadow(blurRadius: 5.0)]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  ),
                  background: Image.network(
                    recipe.strMealThumb,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                    const Center(child: Icon(Icons.broken_image, size: 80,),)
                  ),
                ),
                actions: [
                  IconButton(onPressed: (){
                    viewModel.toggleFavoriteStatus(recipe.idMeal);
                  }, icon: Icon(recipe.isFavorite ? Icons.favorite
                  : Icons.favorite_border,
                  color: Colors.white))
                ],
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  _buildSectionTitle('Ingredients', primaryColor),
                  ...recipe.ingredientsAndMeasures.map((ing) =>
                  _buildListItem(context, Icons.check_circle_outline, ing)),

                  _buildSectionTitle('Instructions', primaryColor),
                  _buildInstructions(context, recipe.strInstructions),
                  const SizedBox(height: 50,),
                ])
                )
            ],
          ),
        
        );

      },
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Padding(padding: EdgeInsets.fromLTRB(
      AppConstants.paddingMedium,
      AppConstants.paddingLarge,
      AppConstants.paddingMedium,
      AppConstants.paddingSmall,
    ),
    child: Text(
      title,
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color),
    ),
    );
  }

  Widget _buildListItem(BuildContext context, IconData icon, String text){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: Theme.of(context).colorScheme.primary.withOpacity(0.8)),
          SizedBox(width: AppConstants.paddingSmall,),
          Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyLarge)),
        ],
      ),
      );
  }

  Widget _buildInstructions(BuildContext context, String instructions) {
    String cleanedInstructions = instructions.replaceAll(RegExp(r'[\r\n]+'), ' ').trim();

    final rawSteps = cleanedInstructions.split('.');
    
    List<Widget> instructionWidgets = [];
    int currentStepNumber = 1; 

    for (var rawStep in rawSteps) {
      String stepText = rawStep.trim();

      stepText = stepText.replaceAll(RegExp(r'^\s*\d+\s*'), '').trim();

      if (stepText.isEmpty) {
        continue;
      }
      
      instructionWidgets.add(
        _buildInstructionItem(context, currentStepNumber, stepText)
      );

      currentStepNumber++; 
    }
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: instructionWidgets,
      ),
    );
  }

  Widget _buildInstructionItem(BuildContext context, int index, String step) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.paddingSmall * 1.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text('$index', style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: AppConstants.paddingSmall),
          Expanded(child: Text(step, style: Theme.of(context).textTheme.bodyLarge)),
        ],
      ),
    );
  }

}
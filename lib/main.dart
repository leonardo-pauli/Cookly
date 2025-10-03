import 'package:cookly/core/app_routes.dart';
import 'package:cookly/core/app_theme.dart';
import 'package:cookly/data/repository/recipe_repository.dart';
import 'package:cookly/data/services/api_service.dart';
import 'package:cookly/viewmodel/home_viewmodel.dart';
import 'package:cookly/viewmodel/search_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Cookly());
}

class Cookly extends StatelessWidget {
  const Cookly({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiService>(create: (_) => ApiService()),
        Provider<RecipeRepository>(
          create: (context) => RecipeRepository(
            apiService: Provider.of<ApiService>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider<HomeViewModel>(
          create: (context) => HomeViewModel(
            repository: Provider.of<RecipeRepository>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider<SearchViewModel>(
          create: (context) => SearchViewModel(
            repository: Provider.of<RecipeRepository>(context, listen: false),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'App de Receitas',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        initialRoute: AppRoutes.home,
        routes: AppRoutes.routes,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

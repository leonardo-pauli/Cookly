import 'package:cookly/view/pages/detail_page.dart';
import 'package:cookly/view/pages/favorites_page.dart';
import 'package:cookly/view/pages/main_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String home = '/';
    static const String favorites = 'favorites';
      static const String recipeDetail = 'recipe_detail';

  static final Map<String, WidgetBuilder> routes = {
    home: (context) => const MainScreen(),

    favorites: (context) => const FavoritesPage(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.recipeDetail:
        final args = settings.arguments; 
        
        if (args is String && args.isNotEmpty) { 
          return MaterialPageRoute(
            builder: (context) => DetailPage(recipeId: args),
          );
        }
        
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: const Text('Erro de Navegação')),
            body: const Center(
              child: Text(
                'Não foi possível carregar a receita. ID inválido ou ausente.',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
    }
    return null;
  }
}
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

    recipeDetail: (context) => const DetailPage()
  };
}
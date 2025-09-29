import 'package:cookly/core/app_routes.dart';
import 'package:cookly/core/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Cookly());
}

class Cookly extends StatelessWidget {
  const Cookly({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Receitas',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
    );
  }
}

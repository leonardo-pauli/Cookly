import 'package:flutter/material.dart';
import '../../../core/constants.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 60, color: Colors.orange),
            SizedBox(height: 16),
            Text(
              'Suas receitas favoritas aparecerão aqui.',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
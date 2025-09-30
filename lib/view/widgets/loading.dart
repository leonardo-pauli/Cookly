import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
   final Color primaryColor = Theme.of(context).colorScheme.primary;

   return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
        ),

        SizedBox(height: 16,),

        Text('Buscando Receitas...',
        style: Theme.of(context).textTheme.titleMedium,)
      ],
    ),
   );
  }
}
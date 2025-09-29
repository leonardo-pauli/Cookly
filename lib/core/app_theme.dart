import 'package:flutter/material.dart';

// Definimos o nome da fonte. O 'Roboto' é uma excelente escolha
// por ser legível e amplamente disponível. Se você usar uma fonte
// customizada, substitua 'Roboto' pelo nome dela.
const String _fontFamily = 'Roboto';

// Cores primárias e de destaque
const Color _primaryColorLight = Color(0xFFFF5722); // Laranja Padrão
const Color _accentColorLight = Color(0xFFFF9800); // Laranja Mais Claro para Destaque
const Color _backgroundColorLight = Colors.white;
const Color _textColorLight = Colors.black87;

const Color _primaryColorDark = Color(0xFFE65100); // Laranja Escuro
const Color _accentColorDark = Color(0xFFFFB74D); // Laranja Claro para Destaque
const Color _backgroundColorDark = Color(0xFF121212); // Preto Escuro (Dark mode padrão)
const Color _textColorDark = Colors.white;


class AppTheme {

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: _primaryColorLight,
      colorScheme: ColorScheme.light(
        primary: _primaryColorLight,
        secondary: _accentColorLight, // Cor de destaque
        background: _backgroundColorLight,
        surface: _backgroundColorLight, // Cor de superfície (cards, sheets)
      ),

      scaffoldBackgroundColor: _backgroundColorLight,
      
      // Tipografia
      fontFamily: _fontFamily,
      textTheme: const TextTheme(
        // Títulos e cabeçalhos em preto
        headlineLarge: TextStyle(color: _textColorLight, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: _textColorLight, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(color: _textColorLight),
        // Corpo do texto
        bodyLarge: TextStyle(color: _textColorLight),
        bodyMedium: TextStyle(color: _textColorLight),
      ),

      // Configuração de AppBar
      appBarTheme: const AppBarTheme(
        color: _primaryColorLight,
        foregroundColor: Colors.white, // Ícones e texto em branco na AppBar
        elevation: 0,
      ),

      // Configuração de Botões
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColorLight,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),

      // Configuração de Cards
      cardTheme: CardThemeData(
        color: _backgroundColorLight,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }


  /// Tema Escuro 
  static ThemeData get darkTheme {
    return ThemeData(
      // Cores principais
      brightness: Brightness.dark,
      primaryColor: _primaryColorDark,
      colorScheme: ColorScheme.dark(
        primary: _primaryColorDark,
        secondary: _accentColorDark, // Cor de destaque no modo escuro
        background: _backgroundColorDark,
        surface: _backgroundColorDark,
      ),

      // Fundo
      scaffoldBackgroundColor: _backgroundColorDark,
      
      // Tipografia
      fontFamily: _fontFamily,
      textTheme: const TextTheme(
        // Títulos e cabeçalhos em branco
        headlineLarge: TextStyle(color: _textColorDark, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: _textColorDark, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(color: _textColorDark),
        // Corpo do texto em branco
        bodyLarge: TextStyle(color: _textColorDark),
        bodyMedium: TextStyle(color: _textColorDark),
      ),
      
      // Configuração de AppBar
      appBarTheme: const AppBarTheme(
        color: _backgroundColorDark, 
        foregroundColor: _textColorDark, 
        elevation: 0,
      ),

      // Configuração de Botões 
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColorDark,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),

      // Configuração de Cards 
      cardTheme: CardThemeData(
        color: const Color(0xFF1E1E1E), 
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
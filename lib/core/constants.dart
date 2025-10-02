class AppConstants {
  // 1. Configuração da API
  static const String baseUrl = 'https://www.theMealdb.com/api/json/v1/1/';
  static const String searchByNameEndpoint = 'search.php';
  static const String lookupByIdEndpoint = 'lookup.php';
  static const String randomstrMealEndpoint = 'random.php';
  static const String searchByFirsLetterEndpoint = 'search.php';
  static const String categoriesEndpoint = 'categories.php';

  // 2. Strings para o UI
  static const String appTitle = 'Meu App de Receitas';
  static const String homeTitle = 'Receitas em Destaque';
  static const String favoritesTitle = 'Minhas Receitas Favoritas';
  static const String loadingMessage = 'Buscando a receita...';
  static const String noDataMessage = 'Nenhuma receita encontrada. :(';

  // 3. Dimensões Comuns
  static const double paddingLarge = 24.0;
  static const double paddingMedium = 16.0;
  static const double paddingSmall = 8.0;
  static const double borderRadius = 12.0;

  // 4. Configurações de Tempo
  static const Duration timeoutDuration = Duration(seconds: 10);
  static const int mockDelayMilliseconds = 1500;
}

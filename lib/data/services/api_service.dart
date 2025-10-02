import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants.dart'; 

/// Serviço responsável por fazer requisições HTTP para a ThestrMealDB.
class ApiService {
  final http.Client _client;

  ApiService({http.Client? client}) : _client = client ?? http.Client();

  /// Busca o JSON dos detalhes de uma receita pelo seu ID.
  Future<Map<String, dynamic>> fetchMealDetails(String idMeal) async {
    final uri = Uri.parse(
        '${AppConstants.baseUrl}${AppConstants.lookupByIdEndpoint}?i=$idMeal');

    return await _get(uri);
  }

  /// Busca uma lista de receitas (ex: para a Home Page).
  Future<List<Map<String, dynamic>>?> searchMeals(String query) async {
    //busca por nome (query)
    final uri = Uri.parse(
        '${AppConstants.baseUrl}${AppConstants.searchByNameEndpoint}?s=$query');
    
    final responseData = await _get(uri);

    // resultados vêm no array 'meals'
    final mealsList = responseData['meals'];

    // Se a API retornar 'null'
    if (mealsList == null || mealsList is! List) {
      return null;
    }
    
    // Retorna a lista de JSONs das receitas
    return mealsList.cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>?> searchMealsByLetter(String letter) async {
    final uri = Uri.parse(
      '${AppConstants.baseUrl}${AppConstants.searchByFirsLetterEndpoint}?f=$letter');

      final responseData = await _get(uri);
      final mealsList = responseData['meals'];

      if(mealsList == null || mealsList is! List){
        return null;
      }

      return mealsList.cast<Map<String, dynamic>>();
    
  }

  //Método Privado de Requisição
  Future<Map<String, dynamic>> _get(Uri uri) async {
    try {
      final response = await _client.get(uri).timeout(AppConstants.timeoutDuration);

      if (response.statusCode == 200) {
        // Decodifica o corpo da resposta
        return json.decode(response.body);
      } else {
        // Lança uma exceção em caso de erro HTTP
        throw Exception('Falha ao carregar dados. Status: ${response.statusCode}');
      }
    } on Exception catch (e) {
      // Captura erros de timeout, rede, etc.
      throw Exception('Erro de conexão com a API: $e');
    }
  }
}
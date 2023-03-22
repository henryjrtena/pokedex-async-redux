import 'package:pokedex_async_redux/api/api_client.dart';
import 'package:pokedex_async_redux/api/handler/pokemon_api.dart';

class ApiService {
  static final ApiService _apiService = ApiService._internal();

  factory ApiService() => _apiService;

  ApiService._internal();

  late final ApiClient _apiClient = ApiClient();

  late final Uri _baseUri = Uri.parse(ApiClient.baseUrl);

  PokemonApi? _pokemonApi;

  PokemonApi get pokemonApi => _pokemonApi ??= PokemonApi(apiClient: _apiClient, baseUri: _baseUri);
}

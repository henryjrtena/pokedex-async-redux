import 'dart:convert';

import 'package:pokedex_async_redux/api/api_client.dart';
import 'package:pokedex_async_redux/api/model/pokemon.dart';
import 'package:pokedex_async_redux/api/model/pokemon_details.dart';

typedef Json = Map<String, dynamic>;

class PokemonApi {
  PokemonApi({
    required this.apiClient,
    required this.baseUri,
  });

  final ApiClient apiClient;
  final Uri baseUri;

  Future<List<Pokemon>> getPokemonList({
    required String offset,
    required String limit,
  }) async {
    final queryParameters = <String, dynamic>{};

    queryParameters['limit'] = limit;
    queryParameters['offset'] = offset;

    final uri = baseUri.replace(
        queryParameters: queryParameters, path: '${baseUri.path}/pokemon');

    return await apiClient.dio.getUri(uri).then((response) {
      return response.data['results']
          .map<Pokemon>((dynamic data) => Pokemon.fromJson(data as Json))
          .toList();
    });
  }

  Future<PokemonDetails> getPokemonDetails({required String name}) async {
    final uri = baseUri.replace(path: '${baseUri.path}pokemon/$name/');
    final response = await apiClient.dio.getUri(uri);

    return PokemonDetails.fromJson(response.data);
  }
}

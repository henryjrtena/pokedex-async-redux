import 'dart:async';
import 'package:pokedex_async_redux/api/api_service.dart';
import 'package:pokedex_async_redux/state/app_state.dart';
import 'package:pokedex_async_redux/utilities/constant.dart';
import 'package:async_redux/async_redux.dart';

/// Getting of Pokemons from Pokemon API
class GetPokemonsAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    final pokemons = await ApiService().pokemonApi.getPokemonList(offset: offSet, limit: limit);
    return state.copyWith(pokemons: pokemons);
  }
}

/// Getting of Pokemon Details from Pokemon API
class GetPokemonDetailsAction extends ReduxAction<AppState> {
  GetPokemonDetailsAction(this.name);

  final String name;

  @override
  Future<AppState> reduce() async {
    final pokemonDetails = await ApiService().pokemonApi.getPokemonDetails(name: name);
    return state.copyWith(pokemonDetails: pokemonDetails);
  }
}

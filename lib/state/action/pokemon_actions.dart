import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:pokedex_async_redux/api/api_service.dart';
import 'package:pokedex_async_redux/state/action/actions.dart';
import 'package:pokedex_async_redux/state/app_state.dart';
import 'package:pokedex_async_redux/utilities/constant.dart';

/// Getting of Pokemons from Pokemon API
class GetPokemonsAction extends LoadingAction {
  static const key = "get-pokemons-action";

  GetPokemonsAction() : super(actionKey: key);

  @override
  Future<AppState> reduce() async {
    final pokemons = await ApiService().pokemonApi.getPokemonList(offset: offSet, limit: limit);
    return state.copyWith(pokemons: pokemons);
  }
}

/// Getting of Pokemon Details from Pokemon API
class GetPokemonDetailsAction extends LoadingAction {
  static const key = "get-pokemons-details-action";

  GetPokemonDetailsAction({required this.pokemonName}) : super(actionKey: key);

  final String pokemonName;

  @override
  Future<AppState> reduce() async {
    final pokemonDetails = await ApiService().pokemonApi.getPokemonDetails(name: pokemonName);
    return state.copyWith(pokemonDetails: pokemonDetails);
  }
}

/// Filters the pokemons in the state the stored the filtered into the searchPokemon state
class SearchPokemonsAction extends LoadingAction {
  static const key = "search-pokemons-action";

  SearchPokemonsAction({required this.searchText}) : super(actionKey: key);

  final String searchText;

  @override
  AppState reduce() {
    final pokemons = state.pokemons.where((pokemon) => pokemon.name.contains(searchText.toLowerCase())).toList();
    return state.copyWith(searchPokemons: pokemons);
  }

  bool get isActive => searchText.isNotEmpty;
}

/// Clear the searchPokemon state to empty
class ClearSearchPokemon extends ReduxAction<AppState> {
  @override
  AppState reduce() => state.copyWith(searchPokemons: List.empty());
}

/// Clears the pokemonDetails state to null
class ClearPokemonDetails extends ReduxAction<AppState> {
  @override
  AppState reduce() => state.copyWith(pokemonDetails: null);
}

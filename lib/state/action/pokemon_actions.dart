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
    pokemons;
    return state.copyWith(pokemons: pokemons);
  }
}

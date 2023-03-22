import 'dart:async';
import 'package:pokedex_async_redux/api/api_service.dart';
import 'package:pokedex_async_redux/state/app_state.dart';
import 'package:async_redux/async_redux.dart';

/// Getting of Pokemon Details from Pokemon API
class GetPokemonDetailsAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    final pokemonDetails = await ApiService().pokemonApi.getPokemonDetails(name: 'bulbasaur');
    return state.copyWith(pokemonDetails: pokemonDetails);
  }
}

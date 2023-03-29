import 'package:pokedex_async_redux/features/pokemon_overview/pokemon_overview_connector.dart';
import 'package:pokedex_async_redux/utilities/constant.dart';
import 'package:pokedex_async_redux/state/action/pokemon_actions.dart';
import 'package:pokedex_async_redux/utilities/async.dart';
import 'package:pokedex_async_redux/api/model/pokemon.dart';
import 'package:pokedex_async_redux/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';

class PokemonOverviewVmFactory extends VmFactory<AppState, PokemonOverviewConnector> {
  @override
  Vm fromStore() => PokemonOverviewVm(
        pokemons: _pokemons,
        onSearchPokemons: _onSearchPokemons,
        onClearSearchPokemons: _onClearSearchPokemons,
      );

  Async<List<Pokemon>> get _pokemons {
    if (state.wait.isWaitingFor(GetPokemonsAction.key)) return const Async.loading();

    if (state.pokemons.isEmpty) return const Async.error(noPokemonsAvailableLabel);

    if (state.isSearching && state.searchPokemons.isEmpty) return const Async.error(noPokemonSearchResult);

    return Async(state.isSearching ? state.searchPokemons : state.pokemons);
  }

  void _onSearchPokemons(String searchText) => dispatchSync(SearchPokemonsAction(searchText: searchText));

  void _onClearSearchPokemons() => dispatchSync(ClearSearchPokemon());
}

class PokemonOverviewVm extends Vm {
  PokemonOverviewVm({
    required this.pokemons,
    required this.onSearchPokemons,
    required this.onClearSearchPokemons,
  }) : super(equals: [pokemons]);

  final Async<List<Pokemon>> pokemons;
  final Function(String) onSearchPokemons;
  final VoidCallback onClearSearchPokemons;
}

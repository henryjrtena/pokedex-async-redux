import 'package:pokedex_async_redux/features/pokemon_overview/pokemon_overview_connector.dart';
import 'package:pokedex_async_redux/utilities/constant.dart';
import 'package:pokedex_async_redux/state/action/pokemon_actions.dart';
import 'package:pokedex_async_redux/utilities/async.dart';
import 'package:pokedex_async_redux/api/model/pokemon.dart';
import 'package:pokedex_async_redux/state/app_state.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

class PokemonOverviewVmFactory extends VmFactory<AppState, PokemonOverviewConnector> {
  @override
  Vm fromStore() => PokemonOverviewVm(
        pokemons: _pokemons(),
        searchedPokemons: _searchedPokemons,
        onSearchedPokemons: _onSearchedPokemons,
        onClearSearchedPokemons: _onClearSearchedPokemons,
      );

  Async<List<Pokemon>> _pokemons() {
    if (state.wait.isWaitingFor(GetPokemonsAction.key)) return const Async.loading();

    if (state.pokemons.isEmpty) return const Async.error(noPokemonsAvailableLabel);

    return Async(state.pokemons);
  }

  List<Pokemon> get _searchedPokemons => state.searchedPokemons;

  void _onSearchedPokemons(searchText) => dispatchSync(SearchPokemonsAction(searchText: searchText));

  void _onClearSearchedPokemons() => dispatchSync(ClearSearchedPokemonAction());
}

class PokemonOverviewVm extends Vm {
  PokemonOverviewVm({
    required this.pokemons,
    required this.searchedPokemons,
    required this.onSearchedPokemons,
    required this.onClearSearchedPokemons,
  }) : super(equals: [
          pokemons,
          searchedPokemons,
        ]);

  final Async<List<Pokemon>> pokemons;
  final List<Pokemon> searchedPokemons;
  final ValueChanged onSearchedPokemons;
  final VoidCallback onClearSearchedPokemons;
}

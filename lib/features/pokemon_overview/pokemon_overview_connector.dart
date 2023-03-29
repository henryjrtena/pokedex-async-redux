import 'package:pokedex_async_redux/features/pokemon_overview/pokemon_overview_page.dart';
import 'package:pokedex_async_redux/features/pokemon_overview/pokemon_overview_vm.dart';
import 'package:pokedex_async_redux/state/action/pokemon_actions.dart';
import 'package:pokedex_async_redux/state/app_state.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

class PokemonOverviewConnector extends StatelessWidget {
  const PokemonOverviewConnector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PokemonOverviewVm>(
      vm: () => PokemonOverviewVmFactory(),
      onInit: (store) => store.dispatchAsync(GetPokemonsAction()),
      builder: (context, vm) => PokemonOverviewPage(
        pokemons: vm.pokemons,
        onSearchPokemons: vm.onSearchPokemons,
        onClearSearchPokemons: vm.onClearSearchPokemons,
      ),
    );
  }
}

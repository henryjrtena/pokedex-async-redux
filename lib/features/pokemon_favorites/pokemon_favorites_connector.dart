import 'package:pokedex_async_redux/features/pokemon_favorites/pokemon_favorites_page.dart';
import 'package:pokedex_async_redux/features/pokemon_favorites/pokemon_favorites_vm.dart';
import 'package:pokedex_async_redux/state/app_state.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

class PokemonFavoritesConnector extends StatelessWidget {
  const PokemonFavoritesConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PokemonFavoritesVm>(
      vm: () => PokemonFavoritesVmFactory(),
      builder: (context, vm) => PokemonFavoritesPage(pokemons: vm.favoritesPokemons),
    );
  }
}

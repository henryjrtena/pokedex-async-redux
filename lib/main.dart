import 'package:async_redux/async_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_async_redux/api/api_service.dart';
import 'package:pokedex_async_redux/features/home_page.dart';
import 'package:pokedex_async_redux/state/app_state.dart';

Future<void> main() async {
  final store = Store<AppState>(
    initialState: AppState(),
    actionObservers: kReleaseMode ? null : [ConsoleActionObserver<AppState>()],
  );

  //TODO: Only for testing. Will remove later.
  final pokemons = await ApiService().pokemonApi.getPokemonList(
        limit: '151',
        offset: '0',
      );

  pokemons;

  runApp(
    StoreProvider(
      store: store,
      child: const HomePage(),
    ),
  );
}

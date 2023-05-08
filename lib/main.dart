import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex_async_redux/api/model/pokemon.dart';
import 'package:pokedex_async_redux/features/pokemon_homepage/pokemon_homepage.dart';
import 'package:pokedex_async_redux/utilities/pokedex_theme.dart';
import 'package:pokedex_async_redux/state/app_state.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('pokedexDB');

  late AppState initialState;

  final pokedexDB = Hive.box('pokedexDB');

  if (pokedexDB.get('appState') == null) {
    initialState = AppState();
  } else {
    final favoritesPokemons = [...pokedexDB.get('appState')]
        .map((pokemon) => Pokemon(name: pokemon['name'], url: pokemon['url'], isFavorite: pokemon['isFavorite']))
        .toList();

    initialState = AppState(favoritesPokemons: favoritesPokemons);
  }

  final store = Store<AppState>(
    initialState: initialState,
    actionObservers: kReleaseMode ? null : [ConsoleActionObserver<AppState>()],
  );

  runApp(
    StoreProvider(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: PokedexTheme.light(),
        home: const PokemonHomePage(),
      ),
    ),
  );
}

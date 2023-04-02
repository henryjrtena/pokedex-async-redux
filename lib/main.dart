import 'package:pokedex_async_redux/features/pokemon_homepage/pokemon_homepage.dart';
import 'package:pokedex_async_redux/state/app_state.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_async_redux/utilities/pokedex_theme.dart';

void main() {
  final store = Store<AppState>(
    initialState: AppState(),
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

import 'package:pokedex_async_redux/state/action/pokemon_actions.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: To be remove for later...
    StoreProvider.dispatch(context, GetPokemonsAction());
    StoreProvider.dispatch(context, GetPokemonDetailsAction('bulbasaur'));

    return MaterialApp(
      // TODO: To remove all hard-coded text and create constant.
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: Text(
            // TODO: To remove all hard-coded text and create constant.
            'Home Page',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
      ),
    );
  }
}

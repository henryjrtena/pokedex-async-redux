import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:hive/hive.dart';
import 'package:pokedex_async_redux/api/api_service.dart';
import 'package:pokedex_async_redux/api/model/pokemon.dart';
import 'package:pokedex_async_redux/api/model/pokemon_setting.dart';
import 'package:pokedex_async_redux/state/action/actions.dart';
import 'package:pokedex_async_redux/state/app_state.dart';

/// Getting of Pokemons from Pokemon API
class GetPokemonsAction extends LoadingAction {
  static const key = "get-pokemons-action";

  GetPokemonsAction() : super(actionKey: key);

  @override
  Future<AppState> reduce() async {
    final pokemons = await ApiService().pokemonApi.getPokemonList(
          offset: state.pokemonSetting.offset,
          limit: state.pokemonSetting.limit,
        );
    return state.copyWith(pokemons: pokemons);
  }
}

/// Getting of Pokemon Details from Pokemon API
class GetPokemonDetailsAction extends LoadingAction {
  static const key = "get-pokemons-details-action";

  GetPokemonDetailsAction({required this.pokemonName}) : super(actionKey: key);

  final String pokemonName;

  @override
  Future<AppState> reduce() async {
    final pokemonDetails =
        await ApiService().pokemonApi.getPokemonDetails(name: pokemonName);
    return state.copyWith(pokemonDetails: pokemonDetails);
  }
}

/// This Action performs a filter on the pokemons using the provided search criteria.
class SearchPokemonsAction extends ReduxAction<AppState> {
  SearchPokemonsAction({required this.searchText});

  final String searchText;

  @override
  AppState reduce() {
    final searchedPokemons = state.pokemons
        .where((pokemon) => pokemon.name.contains(searchText.toLowerCase()))
        .toList();
    return state.copyWith(searchedPokemons: searchedPokemons);
  }
}

/// Clears the searchPokemons state to empty
class ClearSearchedPokemonAction extends ReduxAction<AppState> {
  @override
  AppState reduce() => state.copyWith(searchedPokemons: List.empty());
}

/// Clears the pokemonDetails state to null
class ClearPokemonDetailsAction extends ReduxAction<AppState> {
  @override
  AppState reduce() => state.copyWith(pokemonDetails: null);
}

/// Add Pokemon to the favorites
class AddPokemonToFavoritesAction extends ReduxAction<AppState> {
  AddPokemonToFavoritesAction({required this.pokemon});

  final Pokemon pokemon;

  @override
  Future<AppState> reduce() async {
    final alteredPokemon = pokemon.copyWith(isFavorite: !pokemon.isFavorite);

    final pokemons = [...state.pokemons];
    final indexPokemon =
        state.pokemons.indexWhere((p) => p.name == pokemon.name);
    final favoritesPokemon = [...state.favoritesPokemons];
    final indexFavorite =
        state.favoritesPokemons.indexWhere((p) => p.name == pokemon.name);

    if (indexFavorite != -1) {
      favoritesPokemon.removeAt(indexFavorite);
    } else {
      favoritesPokemon.add(alteredPokemon);
    }

    pokemons[indexPokemon] = alteredPokemon;

    // Update the Favorite Pokemons in the Hive DB
    final pokedexDB = Hive.box('pokedexDB');

    final favouritesPokemons = [...favoritesPokemon]
        .map((pokemon) => {
              'name': pokemon.name,
              'url': pokemon.url,
              'isFavorite': pokemon.isFavorite,
            })
        .toList();

    pokedexDB.put('appState', favouritesPokemons);

    return state.copyWith(
      favoritesPokemons: favoritesPokemon,
      pokemons: pokemons,
    );
  }
}

class SaveNewSettingAction extends ReduxAction<AppState> {
  SaveNewSettingAction({required this.pokemonSetting});

  final PokemonSetting pokemonSetting;

  @override
  AppState reduce() => state.copyWith(pokemonSetting: pokemonSetting);
}

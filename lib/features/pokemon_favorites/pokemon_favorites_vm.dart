import 'package:pokedex_async_redux/features/pokemon_Favorites/pokemon_Favorites_connector.dart';
import 'package:pokedex_async_redux/api/model/pokemon.dart';
import 'package:pokedex_async_redux/state/app_state.dart';
import 'package:async_redux/async_redux.dart';

class PokemonFavoritesVmFactory extends VmFactory<AppState, PokemonFavoritesConnector> {
  @override
  Vm fromStore() => PokemonFavoritesVm(favoritesPokemons: _favoritesPokemons);

  List<Pokemon> get _favoritesPokemons => state.favoritesPokemons;
}

class PokemonFavoritesVm extends Vm {
  PokemonFavoritesVm({
    required this.favoritesPokemons,
  }) : super(equals: [favoritesPokemons]);

  final List<Pokemon> favoritesPokemons;
}

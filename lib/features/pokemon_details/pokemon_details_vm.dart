import 'package:pokedex_async_redux/api/model/pokemon.dart';
import 'package:pokedex_async_redux/api/model/pokemon_details.dart';
import 'package:pokedex_async_redux/features/pokemon_Details/pokemon_Details_connector.dart';
import 'package:pokedex_async_redux/utilities/constant.dart';
import 'package:pokedex_async_redux/state/action/pokemon_actions.dart';
import 'package:pokedex_async_redux/utilities/async.dart';
import 'package:pokedex_async_redux/state/app_state.dart';
import 'package:async_redux/async_redux.dart';

class PokemonDetailsVmFactory extends VmFactory<AppState, PokemonDetailsConnector> {
  @override
  Vm fromStore() => PokemonDetailsVm(
        pokemonDetails: _pokemonDetails(),
        onAddPokemonToFavorites: _onAddPokemonToFavorites,
      );

  Async<PokemonDetails> _pokemonDetails() {
    if (state.wait.isWaitingFor(GetPokemonDetailsAction.key)) return const Async.loading();
    if (state.pokemonDetails == null) return const Async.error(somethingWentWrongMessage);

    return Async(state.pokemonDetails!);
  }

  void _onAddPokemonToFavorites(Pokemon pokemon) => dispatch(AddPokemonToFavoritesAction(pokemon: pokemon));
}

class PokemonDetailsVm extends Vm {
  PokemonDetailsVm({
    required this.pokemonDetails,
    required this.onAddPokemonToFavorites,
  }) : super(equals: [pokemonDetails]);

  final Async<PokemonDetails> pokemonDetails;
  final Function(Pokemon) onAddPokemonToFavorites;
}

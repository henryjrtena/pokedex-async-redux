import 'package:pokedex_async_redux/features/pokemon_overview/pokemon_overview_connector.dart';
import 'package:pokedex_async_redux/utilities/constant.dart';
import 'package:pokedex_async_redux/state/action/pokemon_actions.dart';
import 'package:pokedex_async_redux/utilities/async.dart';
import 'package:pokedex_async_redux/api/model/pokemon.dart';
import 'package:pokedex_async_redux/state/app_state.dart';
import 'package:async_redux/async_redux.dart';

class PokemonOverviewVmFactory extends VmFactory<AppState, PokemonOverviewConnector> {
  @override
  Vm fromStore() => PokemonOverviewVm(pokemons: _pokemons, searchPokemons: _searchPokemons);

  Async<List<Pokemon>> get _pokemons {
    if (state.wait.isWaitingFor(GetPokemonsAction.key)) return const Async.loading();
    if (state.pokemons.isEmpty) return const Async.error(somethingWentWrongMessage);

    return Async(state.pokemons);
  }

  Async<List<Pokemon>> get _searchPokemons {
    if (state.wait.isWaitingFor(SearchPokemonsAction.key)) return const Async.loading();
    if (state.searchPokemons.isEmpty) return const Async.error(noPokemonSearchResult);

    return Async(state.searchPokemons);
  }
}

class PokemonOverviewVm extends Vm {
  PokemonOverviewVm({
    required this.pokemons,
    required this.searchPokemons,
  }) : super(equals: [pokemons, searchPokemons]);

  final Async<List<Pokemon>> pokemons;
  final Async<List<Pokemon>> searchPokemons;
}

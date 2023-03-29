import 'package:pokedex_async_redux/api/model/pokemon.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokedex_async_redux/api/model/pokemon_details.dart';
import 'package:async_redux/async_redux.dart';

part 'app_state.freezed.dart';

part 'app_state.g.dart';

@freezed
class AppState with _$AppState {
  factory AppState({
    @Default(<Pokemon>[]) List<Pokemon> pokemons,
    @Default(<Pokemon>[]) List<Pokemon> searchPokemons,
    @Default(false) bool isSearching,
    @Default(null) PokemonDetails? pokemonDetails,

    // ignored by state
    @Default(Wait.empty) @JsonKey(ignore: true) Wait wait,
  }) = _AppState;

  factory AppState.fromJson(Map<String, dynamic> json) => _$AppStateFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokedex_async_redux/api/model/pokemon_ability.dart';
import 'package:pokedex_async_redux/api/model/pokemon_move.dart';
import 'package:pokedex_async_redux/api/model/pokemon_stats.dart';

part 'pokemon_details.freezed.dart';
part 'pokemon_details.g.dart';

@freezed
class PokemonDetails with _$PokemonDetails {
  const factory PokemonDetails({
    @JsonKey(name: 'height') required double height,
    @JsonKey(name: 'weight') required double weight,
    @JsonKey(name: 'abilities') required List<PokemonAbility> abilities,
    @JsonKey(name: 'moves') required List<PokemonMove> moves,
    @JsonKey(name: 'stats') required List<PokemonStats> stats,
  }) = _PokemonDetails;

  factory PokemonDetails.fromJson(Map<String, dynamic> json) =>
      _$PokemonDetailsFromJson(json);
}

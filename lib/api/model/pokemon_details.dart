import 'package:pokedex_async_redux/api/model/ability.dart';
import 'package:pokedex_async_redux/api/model/move.dart';
import 'package:pokedex_async_redux/api/model/stats.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_details.freezed.dart';

part 'pokemon_details.g.dart';

@freezed
class PokemonDetails with _$PokemonDetails {
  const factory PokemonDetails({
    @JsonKey(name: 'height') required int height,
    @JsonKey(name: 'weight') required int weight,
    @JsonKey(name: 'abilities') required List<Ability> abilities,
    @JsonKey(name: 'moves') required List<Move> moves,
    @JsonKey(name: 'stats') required List<Stats> stats,
  }) = _PokemonDetails;

  factory PokemonDetails.fromJson(Map<String, dynamic> json) => _$PokemonDetailsFromJson(json);
}

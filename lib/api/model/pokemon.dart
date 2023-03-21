import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon.freezed.dart';
part 'pokemon.g.dart';

@freezed
class Pokemon with _$Pokemon {
  const factory Pokemon({
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'url') required String url,
  }) = _Pokemon;
  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);
}
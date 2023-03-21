import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_move.freezed.dart';
part 'pokemon_move.g.dart';

@freezed
class PokemonMove with _$PokemonMove {
  const factory PokemonMove({
    @JsonKey(name: 'move') required MoveInfo move,
  }) = _PokemonMove;

  factory PokemonMove.fromJson(Map<String, dynamic> json) =>
      _$PokemonMoveFromJson(json);
}

@freezed
class MoveInfo with _$MoveInfo {
  const factory MoveInfo({
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'url') required String url,
  }) = _MoveInfo;

  factory MoveInfo.fromJson(Map<String, dynamic> json) =>
      _$MoveInfoFromJson(json);
}

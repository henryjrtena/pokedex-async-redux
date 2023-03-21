import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokedex_async_redux/api/model/move_info.dart';

part 'move.freezed.dart';
part 'move.g.dart';

@freezed
class Move with _$Move {
  const factory Move({
    @JsonKey(name: 'move') required MoveInfo move,
  }) = _Move;
  factory Move.fromJson(Map<String, dynamic> json) =>
      _$MoveFromJson(json);
}
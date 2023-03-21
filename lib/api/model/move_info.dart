import 'package:freezed_annotation/freezed_annotation.dart';

part 'move_info.freezed.dart';
part 'move_info.g.dart';

@freezed
class MoveInfo with _$MoveInfo {
  const factory MoveInfo({
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'url') required String url,
  }) = _MoveInfo;
  factory MoveInfo.fromJson(Map<String, dynamic> json) =>
      _$MoveInfoFromJson(json);
}
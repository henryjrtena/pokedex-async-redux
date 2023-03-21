import 'package:freezed_annotation/freezed_annotation.dart';

part 'ability_info.freezed.dart';

part 'ability_info.g.dart';

@freezed
class AbilityInfo with _$AbilityInfo {
  const factory AbilityInfo({
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'url') required String url,
  }) = _AbilityInfo;

  factory AbilityInfo.fromJson(Map<String, dynamic> json) => _$AbilityInfoFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'stats_info.freezed.dart';

part 'stats_info.g.dart';

@freezed
class StatInfo with _$StatInfo {
  const factory StatInfo({
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'url') required String url,
  }) = _StatInfo;

  factory StatInfo.fromJson(Map<String, dynamic> json) => _$StatInfoFromJson(json);
}

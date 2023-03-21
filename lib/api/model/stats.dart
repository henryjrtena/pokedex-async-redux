import 'package:pokedex_async_redux/api/model/stats_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stats.freezed.dart';

part 'stats.g.dart';

@freezed
class Stats with _$Stats {
  const factory Stats({
    @JsonKey(name: 'base_stat') required double baseStat,
    @JsonKey(name: 'effort') required double effort,
    @JsonKey(name: 'stat') required StatInfo stat,
  }) = _Stats;

  factory Stats.fromJson(Map<String, dynamic> json) => _$StatsFromJson(json);
}

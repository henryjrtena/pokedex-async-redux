import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokedex_async_redux/api/model/ability_info.dart';

part 'ability.freezed.dart';
part 'ability.g.dart';

@freezed
class Ability with _$Ability {
  const factory Ability({
    @JsonKey(name: 'ability') required AbilityInfo ability,
  }) = _Ability;
  factory Ability.fromJson(Map<String, dynamic> json) =>
      _$AbilityFromJson(json);
}
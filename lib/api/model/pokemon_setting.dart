import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_setting.freezed.dart';
part 'pokemon_setting.g.dart';

@freezed
class PokemonSetting with _$PokemonSetting {
  const factory PokemonSetting({
    @Default('151') String limit,
    @Default('0') String offset,
  }) = _PokemonSetting;

  factory PokemonSetting.fromJson(Map<String, dynamic> json) => _$PokemonSettingFromJson(json);
}

import 'package:pokedex_async_redux/api/model/pokemon_setting.dart';
import 'package:pokedex_async_redux/features/pokemon_settings/pokemon_settings_connector.dart';
import 'package:pokedex_async_redux/state/action/pokemon_actions.dart';
import 'package:pokedex_async_redux/state/app_state.dart';
import 'package:async_redux/async_redux.dart';

class PokemonSettingVmFactory extends VmFactory<AppState, PokemonSettingConnector> {
  @override
  Vm fromStore() => PokemonSettingVm(
        pokemonSetting: _pokemonSetting,
        onChangesPokemonSetting: _onChangesPokemonSetting,
      );

  PokemonSetting get _pokemonSetting => state.pokemonSetting;

  void _onChangesPokemonSetting(PokemonSetting pokemonSetting) {
    dispatchSync(SaveNewSettingAction(pokemonSetting: pokemonSetting));
    dispatchAsync(GetPokemonsAction());
  }
}

class PokemonSettingVm extends Vm {
  PokemonSettingVm({
    required this.pokemonSetting,
    required this.onChangesPokemonSetting,
  }) : super(equals: [pokemonSetting]);

  final PokemonSetting pokemonSetting;
  final Function(PokemonSetting) onChangesPokemonSetting;
}

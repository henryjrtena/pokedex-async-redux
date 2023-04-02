import 'package:pokedex_async_redux/features/pokemon_settings/pokemon_settings_page.dart';
import 'package:pokedex_async_redux/features/pokemon_settings/pokemon_settings_vm.dart';
import 'package:pokedex_async_redux/state/app_state.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

class PokemonSettingConnector extends StatelessWidget {
  const PokemonSettingConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PokemonSettingVm>(
      vm: () => PokemonSettingVmFactory(),
      builder: (_, vm) => PokemonSettingPage(
        pokemonSetting: vm.pokemonSetting,
        onChangesPokemonSetting: vm.onChangesPokemonSetting,
      ),
    );
  }
}

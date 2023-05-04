import 'package:flutter/material.dart';
import 'package:pokedex_async_redux/api/model/pokemon_setting.dart';
import 'package:pokedex_async_redux/utilities/colors.dart';

class PokemonSettingPage extends StatefulWidget {
  const PokemonSettingPage({
    required this.pokemonSetting,
    required this.onChangesPokemonSetting,
    Key? key,
  }) : super(key: key);

  final PokemonSetting pokemonSetting;
  final Function(PokemonSetting) onChangesPokemonSetting;

  @override
  State<PokemonSettingPage> createState() => _PokemonSettingPageState();
}

class _PokemonSettingPageState extends State<PokemonSettingPage> {
  late final TextEditingController _limitController;
  late final TextEditingController _offsetController;

  @override
  void initState() {
    super.initState();
    _limitController = TextEditingController(text: widget.pokemonSetting.limit);
    _offsetController = TextEditingController(text: widget.pokemonSetting.offset);
  }

  @override
  void dispose() {
    _limitController.dispose();
    _offsetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _limitController,
              decoration: const InputDecoration(label: Text('Limit')),
            ),
            TextField(
              controller: _offsetController,
              decoration: const InputDecoration(label: Text('Offset')),
            ),
            ElevatedButton(
              onPressed: () => widget.onChangesPokemonSetting(PokemonSetting(
                offset: _offsetController.text,
                limit: _limitController.text,
              )),
              style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(primaryColor)),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:pokedex_async_redux/features/pokemon_overview/widgets/circular_progress_indicator.dart';
import 'package:pokedex_async_redux/features/pokemon_overview/widgets/pokemon_gridview.dart';
import 'package:pokedex_async_redux/features/pokemon_overview/widgets/search_textfield.dart';
import 'package:pokedex_async_redux/utilities/async.dart';
import 'package:pokedex_async_redux/utilities/colors.dart';
import 'package:pokedex_async_redux/utilities/constant.dart';
import 'package:pokedex_async_redux/api/model/pokemon.dart';
import 'package:flutter/material.dart';

class PokemonOverviewPage extends StatefulWidget {
  const PokemonOverviewPage({
    required this.pokemons,
    required this.searchedPokemons,
    required this.onSearchedPokemons,
    required this.onClearSearchedPokemons,
    Key? key,
  }) : super(key: key);

  final Async<List<Pokemon>> pokemons;
  final List<Pokemon> searchedPokemons;
  final ValueChanged onSearchedPokemons;
  final VoidCallback onClearSearchedPokemons;

  @override
  State<PokemonOverviewPage> createState() => _PokemonOverviewPageState();
}

class _PokemonOverviewPageState extends State<PokemonOverviewPage> {
  late final TextEditingController _searchController;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController()..addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    widget.onClearSearchedPokemons();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          SearchTextField(
            controller: _searchController,
            onPressedCloseButton: _onPressedCloseIconButton,
          ),
          Expanded(
            child: _searchController.text.isNotEmpty
                ? widget.searchedPokemons.isEmpty
                    ? const Center(child: Text(noPokemonSearchResult))
                    : PokemonGridView(pokemons: widget.searchedPokemons)
                : widget.pokemons.when(
                    loading: () => const LoadingIndicator(),
                    error: (errorMessage) {
                      WidgetsBinding.instance
                          .addPostFrameCallback((_) => _showErrorMessageSnackbar(errorMessage ?? emptyString));
                      return const Center(child: Text(noPokemonsAvailableLabel));
                    },
                    (pokemons) => PokemonGridView(pokemons: pokemons),
                  ),
          )
        ],
      ),
    );
  }

  void _showErrorMessageSnackbar(String errorMessage) {
    final snackBar = SnackBar(content: Text(errorMessage));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 1000),
      () => widget.onSearchedPokemons(_searchController.text),
    );
  }

  void _onPressedCloseIconButton() {
    _searchController.clear();
    if (_searchController.text.isNotEmpty) return;
    widget.onClearSearchedPokemons();
  }
}

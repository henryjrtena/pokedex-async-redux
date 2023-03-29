import 'dart:async';
import 'package:pokedex_async_redux/features/pokemon_overview/widgets/circular_progress_indicator.dart';
import 'package:pokedex_async_redux/features/pokemon_overview/widgets/pokemon_gridview.dart';
import 'package:pokedex_async_redux/utilities/async.dart';
import 'package:pokedex_async_redux/utilities/colors.dart';
import 'package:pokedex_async_redux/utilities/constant.dart';
import 'package:pokedex_async_redux/api/model/pokemon.dart';
import 'package:pokedex_async_redux/utilities/icons.dart';
import 'package:flutter/material.dart';

class PokemonOverviewPage extends StatefulWidget {
  const PokemonOverviewPage({
    required this.pokemons,
    required this.searchPokemons,
    required this.onSearchPokemons,
    required this.onClearSearchPokemons,
    Key? key,
  }) : super(key: key);

  final Async<List<Pokemon>> pokemons;
  final Async<List<Pokemon>> searchPokemons;
  final Function(String) onSearchPokemons;
  final VoidCallback onClearSearchPokemons;

  @override
  State<PokemonOverviewPage> createState() => _PokemonOverviewPageState();
}

class _PokemonOverviewPageState extends State<PokemonOverviewPage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                iconColor: primaryColor,
                prefixIcon: searchIcon,
                suffixIcon: IconButton(
                  onPressed: () {
                    widget.onClearSearchPokemons();
                    clearTextField();
                  },
                  icon: closeRoundIcon,
                ),
              ),
            ),
          ),
          Expanded(
            child: _debounce != null
                ? widget.searchPokemons.when(
                    loading: () => const LoadingIndicator(),
                    error: (errorMessage) {
                      WidgetsBinding.instance
                          .addPostFrameCallback((_) => _showErrorMessageSnackbar(context, errorMessage));
                      return const Center(child: Text(noPokemonSearchResult));
                    },
                    (data) => PokemonGridView(pokemons: data),
                  )
                : widget.pokemons.when(
                    loading: () => const LoadingIndicator(),
                    error: (errorMessage) {
                      WidgetsBinding.instance
                          .addPostFrameCallback((_) => _showErrorMessageSnackbar(context, errorMessage));
                      return const Center(child: Text(somethingWentWrongMessage));
                    },
                    (data) => PokemonGridView(pokemons: data),
                  ),
          )
        ],
      ),
    );
  }

  void _showErrorMessageSnackbar(BuildContext context, String? errorMessage) {
    final snackBar = SnackBar(content: Text(errorMessage ?? emptyString));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () => widget.onSearchPokemons(_searchController.text));
  }

  void clearTextField() => setState(() => _searchController.text = emptyString);
}

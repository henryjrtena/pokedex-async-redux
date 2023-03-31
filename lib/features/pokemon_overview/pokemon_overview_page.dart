import 'dart:async';
import 'package:pokedex_async_redux/features/pokemon_overview/widgets/circular_progress_indicator.dart';
import 'package:pokedex_async_redux/features/pokemon_overview/widgets/pokemon_card.dart';
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
    _searchController.removeListener(_onSearchChanged);
    _onDisposeSearchedPokemons();

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
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _onClearTextField();
                          if (_searchController.text.isNotEmpty) return;
                          _onDisposeSearchedPokemons();
                        },
                        icon: const Icon(Icons.close_rounded),
                      )
                    : null,
              ),
            ),
          ),
          Expanded(
            child: _searchController.text.isNotEmpty
                ? widget.searchedPokemons.isEmpty
                    ? const Center(child: Text(noPokemonSearchResult))
                    : GridView.builder(
                        padding: const EdgeInsets.all(10.0),
                        itemCount: widget.searchedPokemons.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: pokemonColumnCount),
                        itemBuilder: (_, index) {
                          final pokemon = widget.searchedPokemons[index];
                          return PokemonCard(pokemon: pokemon);
                        },
                      )
                : widget.pokemons.when(
                    loading: () => const LoadingIndicator(),
                    error: (errorMessage) {
                      WidgetsBinding.instance.addPostFrameCallback((_) => _showErrorMessageSnackbar());
                      return Center(child: Text(errorMessage ?? emptyString));
                    },
                    (pokemons) => GridView.builder(
                      padding: const EdgeInsets.all(10.0),
                      itemCount: pokemons.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: pokemonColumnCount),
                      itemBuilder: (_, index) {
                        final pokemon = pokemons[index];
                        return PokemonCard(pokemon: pokemon);
                      },
                    ),
                  ),
          )
        ],
      ),
    );
  }

  void _showErrorMessageSnackbar() {
    const snackBar = SnackBar(content: Text(somethingWentWrongMessage));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () => widget.onSearchedPokemons(_searchController.text));
  }

  void _onClearTextField() => _searchController.clear();

  void _onDisposeSearchedPokemons() => widget.onClearSearchedPokemons();
}

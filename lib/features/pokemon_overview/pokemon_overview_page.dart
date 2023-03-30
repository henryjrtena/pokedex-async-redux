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
    required this.onSearchedPokemons,
    required this.onClearSearchedPokemons,
    Key? key,
  }) : super(key: key);

  final Async<List<Pokemon>> pokemons;
  final Function(String) onSearchedPokemons;
  final VoidCallback onClearSearchedPokemons;

  @override
  State<PokemonOverviewPage> createState() => _PokemonOverviewPageState();
}

class _PokemonOverviewPageState extends State<PokemonOverviewPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchedPokemonEmpty = false;
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
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: _clearTextField,
                        icon: closeRoundIcon,
                      )
                    : null,
              ),
            ),
          ),
          Expanded(
            child: widget.pokemons.when(
              loading: () => const LoadingIndicator(),
              error: (errorMessage) {
                if (_searchController.text.isEmpty && !_isSearchedPokemonEmpty) {
                  WidgetsBinding.instance.addPostFrameCallback((_) => _showErrorMessageSnackbar());
                }
                _setIsSearchedPokemon(true);
                return Center(child: Text(errorMessage!));
              },
              (data) => PokemonGridView(pokemons: data),
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

  void _setIsSearchedPokemon(bool setTo) => setState(() => _isSearchedPokemonEmpty = setTo);

  void _clearTextField() {
    setState(() => _searchController.clear());
    if (_isSearchedPokemonEmpty) return;
    widget.onClearSearchedPokemons();
  }
}

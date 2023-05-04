import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_async_redux/api/model/pokemon.dart';
import 'package:pokedex_async_redux/utilities/constant.dart';
import 'package:pokedex_async_redux/utilities/extension/string_extension.dart';

class PokemonAboutView extends StatefulWidget {
  const PokemonAboutView({
    required this.pokemon,
    required this.height,
    required this.weight,
    required this.onAddToFavorites,
    super.key,
  });

  final Pokemon pokemon;
  final int height;
  final int weight;
  final Function(Pokemon) onAddToFavorites;

  @override
  State<PokemonAboutView> createState() => _PokemonAboutViewState();
}

class _PokemonAboutViewState extends State<PokemonAboutView> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.pokemon.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(widget.pokemon.url.toCustomUrl),
        Text(
          widget.pokemon.name.capitalize(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          '$heightLabel ${widget.height}',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Text(
          '$weightLabel ${widget.weight}',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        IconButton(
          onPressed: _onAddToFavorites,
          icon: Icon(
            Icons.favorite,
            color: isFavorite ? Colors.redAccent : Colors.grey,
          ),
        )
      ],
    );
  }

  void _onAddToFavorites() {
    setState(() => isFavorite = !isFavorite);
    widget.onAddToFavorites(widget.pokemon);
  }
}

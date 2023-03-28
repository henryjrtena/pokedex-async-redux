import 'dart:math';

import 'package:pokedex_async_redux/api/model/stats.dart';
import 'package:pokedex_async_redux/utilities/colors.dart';
import 'package:pokedex_async_redux/utilities/constant.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

class PokemonStatsView extends StatelessWidget {
  const PokemonStatsView({
    required this.pokemonStats,
    super.key,
  });

  final List<Stats> pokemonStats;

  @override
  Widget build(BuildContext context) {
    final deviceWidthSize = MediaQuery.of(context).size.width - paddingBetweenSide;
    return Padding(
      padding: const EdgeInsets.all(paddingSpace20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Wrap(
            runSpacing: statsMarginVertical,
            children: [
              for (var stat in pokemonStats)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          stat.stat.name.capitalize(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          _getBaseStatLabel(stat.baseStat),
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          height: statusBarHeight,
                          width: deviceWidthSize,
                          color: primaryColor.withOpacity(.5),
                        ),
                        Container(
                          height: statusBarHeight,
                          width: deviceWidthSize * (stat.baseStat / baseStatMaxNumber),
                          color: primaryColor,
                        ),
                      ],
                    )
                  ],
                )
            ],
          ),
        ],
      ),
    );
  }

  String _getBaseStatLabel(int baseStat) => '$baseStat/${max(baseStat, baseStatMaxNumber)}';
}

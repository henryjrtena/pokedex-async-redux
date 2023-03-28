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
      padding: const EdgeInsets.all(space20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Wrap(
            runSpacing: wrapRunSpacingForWidgets,
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
                          _getTheBaseStateLabel(stat.baseStat),
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          height: heightOfStatusBar,
                          width: deviceWidthSize,
                          color: primaryColor.withOpacity(.5),
                        ),
                        Container(
                          height: heightOfStatusBar,
                          width: deviceWidthSize * (stat.baseStat / maxNumber),
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

  String _getTheBaseStateLabel(int baseStat) {
    final maxNumberToDisplay = '$baseStat/${max(baseStat, maxNumber)}';
    return maxNumberToDisplay;
  }
}

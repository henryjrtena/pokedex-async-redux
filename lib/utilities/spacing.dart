import 'package:flutter/material.dart';

class VerticalSpacing extends StatelessWidget {
  const VerticalSpacing({
    required this.space,
    super.key,
  });

  final double space;

  @override
  Widget build(BuildContext context) => SizedBox(height: space);
}

class HorizontalSpacing extends StatelessWidget {
  const HorizontalSpacing({
    required this.space,
    super.key,
  });

  final double space;

  @override
  Widget build(BuildContext context) => SizedBox(width: space);
}

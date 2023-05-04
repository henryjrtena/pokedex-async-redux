import 'package:flutter/material.dart';

class VerticalSpacing extends StatelessWidget {
  const VerticalSpacing({
    required this.height,
    super.key,
  });

  final double height;

  @override
  Widget build(BuildContext context) => SizedBox(height: height);
}

class HorizontalSpacing extends StatelessWidget {
  const HorizontalSpacing({
    required this.width,
    super.key,
  });

  final double width;

  @override
  Widget build(BuildContext context) => SizedBox(width: width);
}

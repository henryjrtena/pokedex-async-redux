import 'package:pokedex_async_redux/utilities/colors.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    required this.controller,
    required this.onPressedCloseButton,
    required this.onClearSearchChange,
    super.key,
  });

  final TextEditingController controller;
  final VoidCallback onPressedCloseButton;
  final VoidCallback onClearSearchChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: controller,
        onChanged: (_) => onClearSearchChange(),
        decoration: InputDecoration(
          iconColor: primaryColor,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  onPressed: onPressedCloseButton,
                  icon: const Icon(Icons.close_rounded),
                )
              : null,
        ),
      ),
    );
  }
}

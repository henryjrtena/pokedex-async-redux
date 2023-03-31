import 'package:pokedex_async_redux/utilities/colors.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.controller,
    required this.onPressedCloseButton,
  });

  final TextEditingController controller;
  final VoidCallback onPressedCloseButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: controller,
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

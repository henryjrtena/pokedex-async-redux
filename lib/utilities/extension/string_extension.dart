extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return '';
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String getPokemonId() {
    if (isEmpty) return '';
    final patterns = split('/');
    return patterns[patterns.length - 2];
  }
}

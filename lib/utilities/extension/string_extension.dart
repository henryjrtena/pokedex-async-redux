extension StringExtension on String {
  String get getPokemonId {
    final patterns = split('/');
    return patterns[patterns.length - 2];
  }
}

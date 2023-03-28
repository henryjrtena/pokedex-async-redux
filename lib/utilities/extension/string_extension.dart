import 'package:pokedex_async_redux/utilities/constant.dart';

extension StringExtension on String {
  String get getPokemonId {
    final patterns = split('/');
    return patterns[patterns.length - 2];
  }

  String get toCustomUrl {
    return imageUrl.replaceAll(indexKey, getPokemonId);
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'async.freezed.dart';

@freezed
class Async<T> with _$Async<T> {
  const factory Async(T data) = Data<T>;

  const factory Async.loading() = Loading<T>;

  const factory Async.error(String? errorMessage) = Error<T>;
}

part of 'pagination_bloc.dart';

@immutable
abstract class PaginationEvent<T> {}

class PageFetch<T> implements PaginationEvent<T> {
  PageFetch({
    @required this.callback,
  });

  final Future<List<T>> Function(int currentListSize) callback;

  PageFetch<T> copyWith({
    Future<List<T>> Function(int currentListSize) callback,
  }) {
    return PageFetch<T>(
      callback: callback ?? this.callback,
    );
  }
}

class PageRefreshed<T> implements PaginationEvent<T> {
  PageRefreshed({
    @required this.callback,
  });

  final Future<List<T>> Function(int currentListSize) callback;

  PageRefreshed<T> copyWith({
    Future<List<T>> Function(int currentListSize) callback,
  }) {
    return PageRefreshed<T>(
      callback: callback ?? this.callback,
    );
  }
}

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
    @required this.scrollController,
  });

  final Future<List<T>> Function(int currentListSize) callback;
  final ScrollController scrollController;

  PageRefreshed<T> copyWith(
      {Future<List<T>> Function(int currentListSize) callback,
      ScrollController scrollController}) {
    return PageRefreshed<T>(
      callback: callback ?? this.callback,
      scrollController: scrollController ?? this.scrollController,
    );
  }
}

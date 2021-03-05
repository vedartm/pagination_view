part of 'pagination_bloc.dart';

@immutable
abstract class PaginationState<T> {}

class PaginationInitial<T> extends PaginationState<T> {}

class PaginationError<T> extends PaginationState<T> {
  final dynamic error;
  PaginationError({required this.error});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PaginationError && o.error == error;
  }

  @override
  int get hashCode => error.hashCode;
}

class PaginationLoaded<T> extends PaginationState<T> {
  PaginationLoaded({
    required this.items,
    required this.hasReachedEnd,
  });

  final bool hasReachedEnd;
  final List<T> items;

  @override
  int get hashCode => items.hashCode ^ hasReachedEnd.hashCode;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PaginationLoaded<T> &&
        listEquals(o.items, items) &&
        o.hasReachedEnd == hasReachedEnd;
  }

  PaginationLoaded<T> copyWith({
    List<T>? items,
    bool? hasReachedEnd,
  }) {
    return PaginationLoaded<T>(
      items: items ?? this.items,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
    );
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

part 'pagination_state.dart';

class PaginationCubit<T> extends Cubit<PaginationState<T>> {
  PaginationCubit(this.preloadedItems, this.callback)
      : super(PaginationInitial<T>());

  final List<T> preloadedItems;

  final Future<List<T>> Function(int) callback;

  void fetchPaginatedList() {
    if (state is PaginationInitial) {
      _fetchAndEmitPaginatedList(previousList: preloadedItems);
    } else if (state is PaginationLoaded<T>) {
      final loadedState = state as PaginationLoaded;
      if (loadedState.hasReachedEnd) return;
      _fetchAndEmitPaginatedList(previousList: loadedState.items);
    }
  }

  void refreshPaginatedList(ScrollController scrollController) {
    _fetchAndEmitPaginatedList(previousList: preloadedItems);
    if (scrollController.hasClients) {
      scrollController.jumpTo(0);
    }
  }

  void _fetchAndEmitPaginatedList({List<T> previousList = const []}) async {
    try {
      final newList = await callback(
        _getAbsoluteOffset(previousList.length),
      );
      emit(PaginationLoaded(
        items: previousList + newList,
        hasReachedEnd: newList.isEmpty,
      ));
    } on Exception catch (error) {
      emit(PaginationError(error: error));
    }
  }

  int _getAbsoluteOffset(int offset) => offset - preloadedItems.length;
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/pagination_bloc.dart';
import 'bloc/pagination_bloc.dart';
import 'widgets/bottom_loader.dart';
import 'widgets/empty_separator.dart';
import 'widgets/initial_loader.dart';

typedef PaginationBuilder<T> = Future<List<T>> Function(int currentListSize);

enum PaginationViewType { listView, gridView }

class PaginationView<T> extends StatefulWidget {
  const PaginationView({
    Key key,
    @required this.itemBuilder,
    @required this.pageFetch,
    @required this.onEmpty,
    @required this.onError,
    this.pageRefresh,
    this.separator = const EmptySeparator(),
    this.gridDelegate =
        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    this.preloadedItems = const [],
    this.initialLoader = const InitialLoader(),
    this.bottomLoader = const BottomLoader(),
    this.paginationViewType = PaginationViewType.listView,
    this.shrinkWrap = false,
    this.reverse = false,
    this.scrollDirection = Axis.vertical,
    this.padding = const EdgeInsets.all(0),
    this.physics,
  }) : super(key: key);

  final Widget bottomLoader;
  final Widget initialLoader;
  final Widget onEmpty;
  final EdgeInsets padding;
  final PaginationBuilder<T> pageFetch;
  final PaginationBuilder<T> pageRefresh;
  final ScrollPhysics physics;
  final List<T> preloadedItems;
  final bool reverse;
  final Axis scrollDirection;
  final Widget separator;
  final SliverGridDelegate gridDelegate;
  final PaginationViewType paginationViewType;
  final bool shrinkWrap;

  @override
  PaginationViewState<T> createState() => PaginationViewState<T>();

  final Widget Function(BuildContext, T, int) itemBuilder;

  final Widget Function(dynamic) onError;
}

class PaginationViewState<T> extends State<PaginationView<T>> {
  PaginationBloc<T> _bloc;
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaginationBloc<T>, PaginationState<T>>(
      bloc: _bloc,
      builder: (context, state) {
        if (state is PaginationInitial<T>) {
          return widget.initialLoader;
        } else if (state is PaginationError<T>) {
          return widget.onError(state.error);
        } else {
          final loadedState = state as PaginationLoaded<T>;
          if (loadedState.items.isEmpty) {
            return widget.onEmpty;
          }
          if (widget.paginationViewType == PaginationViewType.gridView) {
            return _buildNewGridView(loadedState);
          }
          return _buildNewListView(loadedState);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _bloc = PaginationBloc<T>(widget.preloadedItems)
      ..add(PageFetch(callback: widget.pageFetch));
  }

  Widget _buildNewListView(PaginationLoaded<T> loadedState) {
    return ListView.separated(
      controller: _scrollController,
      reverse: widget.reverse,
      shrinkWrap: widget.shrinkWrap,
      scrollDirection: widget.scrollDirection,
      physics: widget.physics,
      padding: widget.padding,
      separatorBuilder: (context, index) => widget.separator,
      itemCount: loadedState.hasReachedEnd
          ? loadedState.items.length
          : loadedState.items.length + 1,
      itemBuilder: (context, index) {
        if (index >= loadedState.items.length) {
          _bloc.add(PageFetch(callback: widget.pageFetch));
          return widget.bottomLoader;
        }
        return widget.itemBuilder(context, loadedState.items[index], index);
      },
    );
  }

  Widget _buildNewGridView(PaginationLoaded<T> loadedState) {
    return GridView.builder(
      gridDelegate: widget.gridDelegate,
      controller: _scrollController,
      reverse: widget.reverse,
      shrinkWrap: widget.shrinkWrap,
      scrollDirection: widget.scrollDirection,
      physics: widget.physics,
      padding: widget.padding,
      itemCount: loadedState.hasReachedEnd
          ? loadedState.items.length
          : loadedState.items.length + 1,
      itemBuilder: (context, index) {
        if (index >= loadedState.items.length) {
          _bloc.add(PageFetch(callback: widget.pageFetch));
          return widget.bottomLoader;
        }
        return widget.itemBuilder(context, loadedState.items[index], index);
      },
    );
  }

  void refresh() {
    if (widget.pageRefresh == null) {
      throw Exception('pageRefresh parameter cannot be null');
    }
    _bloc.add(PageRefreshed(callback: widget.pageRefresh));
  }
}

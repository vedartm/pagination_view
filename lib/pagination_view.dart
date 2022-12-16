import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/pagination_bloc.dart';
import 'widgets/bottom_loader.dart';
import 'widgets/empty_separator.dart';
import 'widgets/initial_loader.dart';

typedef PaginationBuilder<T> = Future<List<T>> Function(int currentListSize);

enum PaginationViewType { listView, gridView }

class PaginationView<T> extends StatefulWidget {
  PaginationView({
    Key? key,
    required this.itemBuilder,
    required this.pageFetch,
    required this.onEmpty,
    required this.onError,
    this.pullToRefresh = false,
    this.pullToRefreshCupertino = false,
    this.refreshIndicatorColor = Colors.blue,
    this.gridDelegate =
        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    List<T>? preloadedItems,
    this.initialLoader = const InitialLoader(),
    this.bottomLoader = const BottomLoader(),
    this.paginationViewType = PaginationViewType.listView,
    this.shrinkWrap = false,
    this.reverse = false,
    this.scrollDirection = Axis.vertical,
    this.padding = const EdgeInsets.all(0),
    this.physics,
    this.separatorBuilder,
    this.scrollController,
    this.headerAlwaysVisible = false,
    this.header,
    this.footerAlwaysVisible = false,
    this.footer,
  })  : preloadedItems = preloadedItems ?? <T>[],
        super(key: key);

  final Widget bottomLoader;

  /// Default false
  final bool footerAlwaysVisible;
  final List<Widget>? footer;
  final SliverGridDelegate gridDelegate;

  /// Default false
  final bool headerAlwaysVisible;
  final List<Widget>? header;
  final Widget initialLoader;
  final Widget onEmpty;
  final EdgeInsets padding;
  final PaginationBuilder<T> pageFetch;
  final PaginationViewType paginationViewType;
  final ScrollPhysics? physics;
  final List<T> preloadedItems;
  final bool pullToRefresh;

  /// Pull to refresh stylized as Cupertino
  ///
  /// Only if pullToRefresh == true
  ///
  /// Default false
  final bool pullToRefreshCupertino;
  final Color refreshIndicatorColor;
  final bool reverse;
  final ScrollController? scrollController;
  final Axis scrollDirection;
  final bool shrinkWrap;

  @override
  PaginationViewState<T> createState() => PaginationViewState<T>();

  final Widget Function(BuildContext, T, int) itemBuilder;

  final Widget Function(BuildContext, int)? separatorBuilder;

  final Widget Function(dynamic) onError;
}

class PaginationViewState<T> extends State<PaginationView<T>> {
  PaginationCubit<T>? _cubit;
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _cubit = PaginationCubit<T>(widget.preloadedItems, widget.pageFetch)
      ..fetchPaginatedList();
  }

  Future<void> refresh() async {
    await _cubit!.refreshPaginatedList();
    if (_scrollController!.hasClients) {
      _scrollController!.animateTo(
        0,
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 200),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaginationCubit<T>, PaginationState<T>>(
      bloc: _cubit,
      builder: (context, state) {
        /// Checking that the data has already been loaded and is not empty
        bool loaded = (state is PaginationLoaded<T>) && state.items.isNotEmpty;

        bool showHeader = widget.header?.isNotEmpty == true &&
            (widget.headerAlwaysVisible || loaded);
        bool showFooter = widget.footer?.isNotEmpty == true &&
            (widget.footerAlwaysVisible || loaded);

        /// For Cupertino styled pull to refresh need to show header
        bool cupertinoRefresh =
            widget.pullToRefresh && widget.pullToRefreshCupertino;
        return _buildCustomWidget(
          [
            if (cupertinoRefresh)
              CupertinoSliverRefreshControl(
                onRefresh: refresh,
              ),
            if (showHeader) ...widget.header!,
            SliverPadding(
              padding: widget.padding,
              sliver: _buildSliverBody(state),
            ),
            if (showFooter) ...widget.footer!,
          ],
        );
      },
    );
  }

  Widget _buildCustomWidget(List<Widget> slivers) {
    var result = CustomScrollView(
      reverse: widget.reverse,
      controller: _scrollController,
      shrinkWrap: widget.shrinkWrap,
      scrollDirection: widget.scrollDirection,
      physics: AlwaysScrollableScrollPhysics(parent: widget.physics),
      slivers: slivers,
    );
    if (widget.pullToRefresh && widget.pullToRefreshCupertino == false) {
      return RefreshIndicator(
        color: widget.refreshIndicatorColor,
        onRefresh: refresh,
        child: result,
      );
    }
    return result;
  }

  /// Get only body widget, without header and footer
  Widget _buildSliverBody(PaginationState<T> state) {
    if (state is PaginationInitial<T>) {
      return _buildSliverSingleView(
        widget.initialLoader,
      );
    }
    if (state is PaginationError<T>) {
      return _buildSliverSingleView(
        widget.onError(state.error),
      );
    }
    final loadedState = state as PaginationLoaded<T>;
    if (loadedState.items.isEmpty) {
      return _buildSliverSingleView(widget.onEmpty);
    }
    return _buildSliverScrollView(loadedState);
  }

  Widget _buildSliverSingleView(Widget child) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: child,
    );
  }

  Widget _buildSliverScrollView(PaginationLoaded<T> loadedState) {
    if (widget.paginationViewType == PaginationViewType.gridView) {
      return _buildSliverGrid(loadedState);
    }
    return _buildSliverList(loadedState);
  }

  Widget _buildSliverGrid(PaginationLoaded<T> loadedState) {
    return SliverGrid(
      gridDelegate: widget.gridDelegate,
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index >= loadedState.items.length) {
            _cubit!.fetchPaginatedList();
            return widget.bottomLoader;
          }
          return widget.itemBuilder(context, loadedState.items[index], index);
        },
        childCount: loadedState.hasReachedEnd
            ? loadedState.items.length
            : loadedState.items.length + 1,
      ),
    );
  }

  Widget _buildSliverList(PaginationLoaded<T> loadedState) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final itemIndex = index ~/ 2;
          if (index.isEven) {
            if (itemIndex >= loadedState.items.length) {
              _cubit!.fetchPaginatedList();
              return widget.bottomLoader;
            }
            return widget.itemBuilder(
                context, loadedState.items[itemIndex], itemIndex);
          }
          return widget.separatorBuilder != null
              ? widget.separatorBuilder!(context, itemIndex)
              : const EmptySeparator();
        },
        semanticIndexCallback: (widget, localIndex) {
          if (localIndex.isEven) {
            return localIndex ~/ 2;
          }
          // ignore: avoid_returning_null
          return null;
        },
        childCount: max(
            0,
            (loadedState.hasReachedEnd
                        ? loadedState.items.length
                        : loadedState.items.length + 1) *
                    2 -
                1),
      ),
    );
  }
}

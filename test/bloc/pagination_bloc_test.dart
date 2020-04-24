import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pagination_view/bloc/pagination_bloc.dart';

void main() {
  group('PaginationBloc', () {
    final tPreloadedList = [1, 2];
    final tList = [1, 2, 3, 4];

    Future<List<int>> _pageFetch(int offset) {
      return Future<List<int>>.value(tList);
    }

    blocTest(
      'when nothing is added emits [] ',
      build: () async => PaginationBloc<int>([]),
      expect: [],
    );

    blocTest(
      'when preloaded data is added emits []',
      build: () async => PaginationBloc<int>(tPreloadedList),
      expect: [],
    );

    blocTest(
      'when page fetched emits PaginationLoaded',
      build: () async => PaginationBloc<int>(tPreloadedList),
      act: (bloc) => bloc.add(PageFetch<int>(callback: _pageFetch)),
      expect: [isA<PaginationLoaded>()],
    );
  });
}

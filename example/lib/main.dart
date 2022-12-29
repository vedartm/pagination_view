import 'package:example/user.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:pagination_view/pagination_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int page;
  late PaginationViewType paginationViewType;
  late Axis scrollDirection;
  late GlobalKey<PaginationViewState> key;

  @override
  void initState() {
    page = -1;
    paginationViewType = PaginationViewType.listView;
    scrollDirection = Axis.vertical;
    key = GlobalKey<PaginationViewState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PaginationView Example'),
        actions: <Widget>[
          (paginationViewType == PaginationViewType.listView)
              ? IconButton(
                  icon: Icon(Icons.grid_on),
                  onPressed: () => setState(
                      () => paginationViewType = PaginationViewType.gridView),
                )
              : IconButton(
                  icon: Icon(Icons.list),
                  onPressed: () => setState(
                      () => paginationViewType = PaginationViewType.listView),
                ),
          IconButton(
            icon: Icon(Icons.android),
            onPressed: () {
              setState(() {
                scrollDirection = scrollDirection == Axis.horizontal
                    ? Axis.vertical
                    : Axis.horizontal;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => key.currentState?.refresh(),
          ),
        ],
      ),
      body: PaginationView<User>(
        key: key,
        header: [SliverToBoxAdapter(child: Text('Header text'))],
        footer: [SliverToBoxAdapter(child: Text('Footer text'))],
        paginationViewType: paginationViewType,
        itemBuilder: (BuildContext context, User user, int index) =>
            (paginationViewType == PaginationViewType.listView)
                ? Container(
                    width: scrollDirection == Axis.horizontal ? 300 : null,
                    child: ListTile(
                      title: Text(user.name),
                      subtitle: Text(user.email),
                      leading: CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                    ),
                  )
                : GridTile(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(child: Icon(Icons.person)),
                        const SizedBox(height: 8),
                        Text(user.name),
                        const SizedBox(height: 8),
                        Text(user.email),
                      ],
                    ),
                  ),
        pageFetch: pageFetch,
        scrollDirection: scrollDirection,
        pullToRefresh: true,
        pullToRefreshCupertino: true,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          childAspectRatio: 10 / 16,
          maxCrossAxisExtent: 320,
        ),
        physics: BouncingScrollPhysics(),
        onError: (Exception error) => Center(
          child: Text('Some error occurred'),
        ),
        onEmpty: Center(child: Text('Sorry! This is empty')),
        bottomLoader: Center(child: CircularProgressIndicator()),
        initialLoader: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Future<List<User>> pageFetch(int offset) async {
    int itemCount = 10;
    print('pageFetch: $offset');
    page = (offset / itemCount).round();
    final Faker faker = Faker();
    final List<User> nextUsersList = List.generate(
      itemCount,
      (int index) => User(
        faker.person.name() + ' - $page$index',
        faker.internet.email(),
      ),
    );
    return Future.delayed(
      Duration(seconds: 1),
      () => page == itemCount ? [] : nextUsersList,
    );
  }
}

class PaginationTestOnDifferentSize extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 5, child: Container()),
          Expanded(
            flex: 3,
            child: HomePage(),
          )
        ],
      ),
    );
  }
}

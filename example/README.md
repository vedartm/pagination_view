#### `example/lib/main.dart`

```dart
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PaginationView Example')),
      body: PaginationView<User>(
        itemBuilder: (BuildContext context, User user) => ListTile(
          title: Text(user.name),
          subtitle: Text(user.email),
          leading: IconButton(
            icon: Icon(Icons.person),
            onPressed: () => null,
          ),
        ),
        pageFetch: pageFetch,
        onError: (dynamic error) => Center(
          child: Text('Some error occured'),
        ),
        onEmpty: Center(
          child: Text('Sorry! This is empty'),
        ),
      ),
    );
  }

  Future<List<User>> pageFetch(int offset) async {
    final Faker faker = Faker();
    final List<User> nextUsersList = List.generate(
        10, (int index) => User(faker.person.name(), faker.internet.email()));
    await Future<List<User>>.delayed(Duration(seconds: 3));
    return nextUsersList;
  }
}

class User {
  User(this.name, this.email);

  final String name;
  final String email;
}

```
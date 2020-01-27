# PaginationView

[![pub package](https://img.shields.io/badge/pub-0.4.0-blueviolet.svg)](https://pub.dev/packages/pagination_view)

<p align="center">
  <img src="https://raw.githubusercontent.com/excogitatr/pagination_view/master/assets/pagination_view_screen.gif" height="500px">
</p>

## Installing

In your pubspec.yaml

```yaml
dependencies:
  pagination_view: ^0.4.0
```

```dart
import 'package:pagination_view/pagination_view.dart';
```

## Basic Usage

```dart
    PaginationView<User>(
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
    );
```

## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

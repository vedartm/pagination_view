# PaginationView
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-1-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

[![Actions Status](https://github.com/excogitatr/pagination_view/workflows/build/badge.svg)](https://github.com/excogitatr/pagination_view/actions?query=workflow%3Abuild)
[![pub package](https://img.shields.io/pub/v/pagination_view.svg)](https://pub.dev/packages/pagination_view)
[![style: effective dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://github.com/tenhobi/effective_dart)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

<p align="center">
  <img src="https://raw.githubusercontent.com/excogitatr/pagination_view/master/assets/pagination_view_screen.gif" height="500px">
</p>

## Installing

In your pubspec.yaml

```yaml
dependencies:
  pagination_view: ^1.0.1
```

```dart
import 'package:pagination_view/pagination_view.dart';
```

## Basic Usage

```dart
      PaginationView<User>(
        preloadedItems: <User>[
          User(faker.person.name(), faker.internet.email()),
          User(faker.person.name(), faker.internet.email()),
        ],
        itemBuilder: (BuildContext context, User user, int index) => ListTile(
          title: Text(user.name),
          subtitle: Text(user.email),
          leading: IconButton(
            icon: Icon(Icons.person),
            onPressed: () => null,
          ),
        ),
        paginationViewType: PaginationViewType.listView // optional
        pageFetch: pageFetch,
        onError: (dynamic error) => Center(
          child: Text('Some error occured'),
        ),
        onEmpty: Center(
          child: Text('Sorry! This is empty'),
        ),
        bottomLoader: Center( // optional
          child: CircularProgressIndicator(),
        ),
        initialLoader: Center( // optional
          child: CircularProgressIndicator(),
        ),
      ),
```

## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="http://Facebook.com/Saifallak"><img src="https://avatars3.githubusercontent.com/u/6053156?v=4" width="100px;" alt=""/><br /><sub><b>Saif Allah Khaled</b></sub></a><br /><a href="https://github.com/excogitatr/pagination_view/commits?author=Saifallak" title="Code">💻</a></td>
  </tr>
</table>

<!-- markdownlint-enable -->
<!-- prettier-ignore-end -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
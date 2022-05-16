# PaginationView

<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->

[![All Contributors](https://img.shields.io/badge/all_contributors-5-orange.svg?style=flat-square)](#contributors-)

<!-- ALL-CONTRIBUTORS-BADGE:END -->

[![Actions Status](https://github.com/excogitatr/pagination_view/workflows/build/badge.svg)](https://github.com/excogitatr/pagination_view/actions?query=workflow%3Abuild)
[![pub package](https://img.shields.io/pub/v/pagination_view.svg)](https://pub.dev/packages/pagination_view)
[![pub points](https://badges.bar/pagination_view/pub%20points)](https://pub.dev/packages/pagination_view/score)
[![style: effective dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://github.com/tenhobi/effective_dart)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

<p align="center">
  <img src="https://raw.githubusercontent.com/excogitatr/pagination_view/master/assets/pagination_view_screen.gif" height="500px">
</p>

## Installing

In your pubspec.yaml

```yaml
dependencies:
  pagination_view: ^2.0.0
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
        header: Text('Header text'),
        footer: Text('Footer text'),
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

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://Facebook.com/Saifallak"><img src="https://avatars3.githubusercontent.com/u/6053156?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Saif Allah Khaled</b></sub></a><br /><a href="https://github.com/excogitatr/pagination_view/commits?author=Saifallak" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/jezsung"><img src="https://avatars2.githubusercontent.com/u/45475169?v=4?s=100" width="100px;" alt=""/><br /><sub><b>jezsung</b></sub></a><br /><a href="https://github.com/excogitatr/pagination_view/commits?author=jezsung" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/psredzinski"><img src="https://avatars0.githubusercontent.com/u/23390884?v=4?s=100" width="100px;" alt=""/><br /><sub><b>psredzinski</b></sub></a><br /><a href="https://github.com/excogitatr/pagination_view/commits?author=psredzinski" title="Code">💻</a></td>
    <td align="center"><a href="https://vivaldee.com"><img src="https://avatars.githubusercontent.com/u/19719900?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Javier Torrus</b></sub></a><br /><a href="https://github.com/excogitatr/pagination_view/commits?author=JTorrus" title="Code">💻</a></td>
    <td align="center"><a href="https://jonjomckay.com"><img src="https://avatars.githubusercontent.com/u/456645?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Jonjo McKay</b></sub></a><br /><a href="https://github.com/excogitatr/pagination_view/commits?author=jonjomckay" title="Code">💻</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!

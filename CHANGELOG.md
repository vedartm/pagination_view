## 2.0.0-nullsafety.0

- BREAKING: Opt into null safety

## 1.0.4+2

- Updates pub packages

## 1.0.4+1

- Fixes refresh issue and removes `pageRefersh`

## 1.0.4

- Added support for `header` and `footer` 

## 1.0.3+2

- Updated `flutter_bloc` to v6.0.1

## 1.0.3+1

- Updated `flutter_bloc` to v5.0.1

## 1.0.3

- Added `pullToRefresh` to enable swipe to refresh to the pagination view
- Added optional `scrollController` attribute
- Added `pageRefresh` to use custom onTap to refresh. (Check example)

### Breaking Change:

- Changed `seperator` to `separatorBuilder`

## 1.0.1

- Added Support for GridView type ([#7](https://github.com/excogitatr/pagination_view/issues/7)) [@Saifallak](https://github.com/Saifallak)

### Breaking Change:

- the item builder has a new parameter (index).

## 1.0.0+1

- Fixed bottomLoader visible if list is short ([#3](https://github.com/excogitatr/pagination_view/issues/3))

## 1.0.0 (Breaking changes)

- Moved to `bloc` to handle state changes
- Check example for change in parameters

## 0.7.0

- Added Refresh Indicator which can be enabled by `onRefresh` property

## 0.6.0

- Added `reverse` attribute

## 0.5.0

- Fixed `NoSuchMethodError`

## 0.4.0

- Added necessary ListView attributes like `shrinkWrap`, `physics`, etc.,

## 0.3.0

- Now you can preload list view with `initialData`

## 0.2.0

- Change in Example and Description

## 0.1.0

- Initial release

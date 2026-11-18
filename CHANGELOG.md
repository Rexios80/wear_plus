# 1.2.6

- Replaces the deprecated `package:flutter/material.dart` import with `package:flutter/widgets.dart`

# 1.2.5

- Updates minimum supported SDK version to Flutter 3.44/Dart 3.12.
- Migrates to built-in Kotlin

# 1.2.4

- Android compileSdkVersion 36

# 1.2.3

- Replaces deprecated native lifecycle observer methods (by [@Crdzbird](https://github.com/Crdzbird) in [#6](https://github.com/Rexios80/wear_plus/pull/6))

# 1.2.2

- Fixes build issue

# 1.2.1

- Updates proguard rules for R8

# 1.2.0

- First release of `wear_plus`. Replace any references to the `wear` plugin with `wear_plus` to switch.
- `InheritedShape` is now private. This would be a breaking change if this wasn't the first release of a new plugin.

# 1.1.0

- Fix issue with non-windows builds breaking.

# 1.0.0

- Null Safety Migration (Finally!)
  - Thanks to Rexios and Peter Ullrich.
  - Min Dart 2.12 / Flutter 2.5
- Updated native component versions:
  - Gradle 6.5
  - Android Gradle Plugin 4.1.0
  - Android compileSdkVersion 31
  - AndroidX Wear 1.2.0
  - Kotlin 1.5.10
  - Removed `jcenter()` repo requirement.

# 0.1.1

- Fix Kotlin/Android compileOnly dep on com.google.android.wearable:wearable.

# 0.1.0

- Updated to AndroidX and Android embedding v2.
- Renamed `Shape` is now `WearShape`.
- Renamed `Mode` is now `WearMode`.
- Deprecated `InheritedShape`.
  _Add `WatchShape` instead and use `WatchShape.of(context)` to get the shape value._

# 0.0.1

- Initial release

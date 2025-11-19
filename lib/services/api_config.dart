import 'package:flutter/foundation.dart';

/// Centralized configuration for Django base URLs.
class ApiConfig {
  static const String _productionBase =
      'https://hasanul-muttaqin-eshoppbp.pbp.cs.ui.ac.id';

  static String get _developmentBase {
    // Flutter web + desktop runs on localhost, Android emulator still needs 10.0.2.2
    const devDesktopBase = 'http://localhost:8000';
    const devEmulatorBase = 'http://10.0.2.2:8000';

    if (kIsWeb) {
      return devDesktopBase;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.windows:
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
        return devDesktopBase;
      default:
        return devEmulatorBase;
    }
  }

  static String get baseUrl =>
      kReleaseMode ? _productionBase : _developmentBase;

  static String resolve(String path) {
    if (path.startsWith('/')) {
      return '$baseUrl$path';
    }
    return '$baseUrl/$path';
  }
}

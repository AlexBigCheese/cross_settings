import 'settings_stub.dart'
    if (dart.library.html) 'settings_web.dart'
    if (flutter.library.foundation) 'settings_flutter.dart'
    if (dart.library.io) 'settings_vm.dart';

abstract class Settings {
  /// Creates a platform-appropriate [Settings] object
  ///
  /// On the web, uses [BrowserSettings]
  /// On flutter and vm, uses [IOSettings]
  factory Settings({String vmBase}) => createSettings(vmBase);

  /// Loads settings from a slot / file
  ///
  /// In the browser the's would be `localStorage` keys
  /// In flutter these are in `path_provider`'s application documents directories
  /// In the vm these are in `~/.config/appName` for linux, `%APPDATA%/appName` on windows, and `~/Library/Applicaion Support/appName` on macOs
  Future<Map> loadSettings(String settingsFile);

  /// Saves settings to a slot / file
  ///
  /// In the browser the's would be `localStorage` keys
  /// In flutter these are in `path_provider`'s application documents directories
  /// In the vm these are in `~/.config/appName` for linux, `%APPDATA%/appName` on windows, and `~/Library/Applicaion Support/appName` on macOs
  Future saveSettings(String settingsFile, Map settings);
}

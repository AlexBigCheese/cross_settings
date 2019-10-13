// ignore: uri_does_not_exist
import 'settings_stub.dart'
// ignore: uri_does_not_exist
    if (dart.library.io) 'settings_flutter.dart'
// ignore: uri_does_not_exist
    if (dart.library.html) 'settings_web.dart';

abstract class Settings {
  static List<Settings> _instances = [];

  /// Creates a platform-appropriate [Settings] object
  ///
  /// On the web, uses [BrowserSettings]
  /// On flutter and vm, uses [IOSettings]
  factory Settings({String vmBase, int instanceSlot = 0}) {
    instanceSlot ??= 0;
    if (instanceSlot.isNegative) throw IndexError(instanceSlot, _instances);
    if (_instances.length > instanceSlot && _instances[instanceSlot] != null) {
      return _instances[instanceSlot];
    }
    var settings = createSettings(vmBase);
    _instances.add(settings);
    return settings;
  }

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

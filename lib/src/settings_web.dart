// ignore: uri_does_not_exist
import 'dart:html';
import 'dart:convert' show json;
import 'settings.dart';

/// A [Settings] implementation for the browser
class BrowserSettings implements Settings {
  @override
  Future<Map> loadSettings(String settingsFile) async {
    // ignore: undefined_identifier
    if (window.localStorage.containsKey([settingsFile])) {
      // ignore: undefined_identifier
      return json.decode(window.localStorage[settingsFile]);
    }
    return {};
  }

  @override
  Future saveSettings(String settingsFile, Map settings) async {
    // ignore: undefined_identifier
    return window.localStorage[settingsFile] = json.encode(settings);
  }
}

createSettings(_) => BrowserSettings();

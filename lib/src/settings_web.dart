import 'dart:html';
import 'dart:convert' show json;
import 'settings.dart';

/// A [Settings] implementation for the browser
class BrowserSettings implements Settings {
  @override
  Future<Map> loadSettings(String settingsFile) async {
    if (window.localStorage.containsKey([settingsFile])) {
      return json.decode(window.localStorage[settingsFile]);
    }
    return null;
  }

  @override
  Future saveSettings(String settingsFile, Map settings) async {
    return window.localStorage[settingsFile] = json.encode(settings);
  }
}

createSettings(_) => BrowserSettings();

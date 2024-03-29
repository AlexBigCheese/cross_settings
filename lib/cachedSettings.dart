library cross_settings.cached;

import 'dart:async';
import 'cross_settings.dart';

/// An implementation of [Settings] that caches and doesn't save directly
class CachedSettings<T extends Settings> implements Settings {
  /// The wrapped [Settings] object
  final T settings;

  /// The cached settings
  Map<String,Map> cache = {};

  /// Actually saves all the settings in cache
  Future saveAll() => Future.wait([
    for (var c in cache.entries)
      settings.saveSettings(c.key,c.value)
  ]);

  static List<CachedSettings> _prevInstances = [];

  CachedSettings._(this.settings);

  factory CachedSettings.fromSettings(T settings) {
    if (_prevInstances.any((x) => x.settings == settings)) {
      return _prevInstances.firstWhere((x) => x.settings == settings);
    }
    var bs = CachedSettings._(settings);
    _prevInstances.add(bs);
    return bs;
  }

  factory CachedSettings({String vmBase}) =>
      CachedSettings.fromSettings(Settings(vmBase: vmBase));

  @override
  Future<Map> loadSettings(String settingsFile) async {
    if (cache.containsKey(settingsFile)) return cache[settingsFile];
    Map s = await settings.loadSettings(settingsFile);
    cache[settingsFile] = s;
    return s;
  }

  @override
  Future saveSettings(String settingsFile, Map settings) async {
    cache[settingsFile] = settings;
  }
}

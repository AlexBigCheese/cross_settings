library cross_settings.bloc;
import 'dart:async';

import 'package:cross_settings/cross_settings.dart';

/// An implementation of [Settings] that wraps another [Settings] and will update a stream whenever a `settingsFile` is saved to
class BLoCSettings<T extends Settings> implements Settings {
  /// The wrapped [Settings] object
  final T settings;

  /// Get a stream of saves on a `settingsFile`
  Stream<Map> saveStream(String settingsFile) => _saves.stream.where((x) => x.key == settingsFile).map((x) => x.value);

  static List<BLoCSettings> _prevInstances = [];

  StreamController<MapEntry<String,Map>> _saves = StreamController.broadcast();

  BLoCSettings._(this.settings);

  factory BLoCSettings.fromSettings(T settings) {
    if (_prevInstances.any((x) => x.settings == settings)) return _prevInstances.firstWhere((x) => x.settings == settings);
    var bs = BLoCSettings._(settings);
    _prevInstances.add(bs);
    return bs;
  }

  factory BLoCSettings({String vmBase}) => BLoCSettings.fromSettings(Settings(vmBase: vmBase));

  @override
  Future<Map> loadSettings(String settingsFile) => settings.loadSettings(settingsFile);

  @override
  Future saveSettings(String settingsFile, Map settings) {
    _saves.add(MapEntry(settingsFile, settings));
    return this.settings.saveSettings(settingsFile,settings);
  }
}
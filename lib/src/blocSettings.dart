library cross_settings.bloc;
import 'dart:async';

import 'package:cross_settings/cross_settings.dart';

class BLoCSettings implements Settings {
  final Settings settings;

  Stream saveStream(String settingsFile) => _saves.stream.where((x) => x.key == settingsFile).map((x) => x.value);

  static List<BLoCSettings> _prevInstances = [];

  StreamController<MapEntry<String,Map>> _saves = StreamController.broadcast();

  BLoCSettings._(this.settings);

  factory BLoCSettings.fromSettings(settings) {
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
import 'dart:io';
import 'dart:convert' show json;
import 'settings.dart';

class IOSettings implements Settings {
  final String vmBase;
  final Future<Directory> futureBase;
  IOSettings({this.vmBase, this.futureBase});
  @override
  Future<Map> loadSettings(String settingsFile) async {
    print("loading $settingsFile");
    String pBase = (futureBase != null) ? (await futureBase).path : vmBase;
    File f = File(pBase + Platform.pathSeparator + settingsFile + ".json");
    if (!(await f.exists())) return {};
    return json.decode(await f.readAsString());
  }

  @override
  Future saveSettings(String settingsFile, Map settings) async {
    String pBase = (futureBase != null) ? (await futureBase).path : vmBase;
    File f = File(pBase + Platform.pathSeparator + settingsFile + ".json");
    if (!(await f.exists())) {
      await f.create(recursive: true);
    }
    return f.writeAsString(json.encode(settings));
  }
}

createSettings(vmBase) => IOSettings(vmBase: vmBase);

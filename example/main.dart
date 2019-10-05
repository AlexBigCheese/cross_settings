import 'package:cross_settings/cross_settings.dart';

main() async {
  Settings settingsManager = Settings(vmBase: "cross_settings_example");
  Map settings = await settingsManager.loadSettings("main") ?? {};
  var now = DateTime.now();
  print("Currently it's $now");
  var lastRan = DateTime.tryParse(settings["lastOpened"]);
  print("This program was last ran ${lastRan != null ? "on " + lastRan.toString() : "never"}");
  settings["lastOpened"] = now.toIso8601String();
}
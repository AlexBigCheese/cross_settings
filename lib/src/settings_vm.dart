import 'dart:io';
import 'settings_io.dart' hide createSettings;

createSettings(String vmBase) {
  if (Platform.isLinux) {
    return IOSettings(
        vmBase: Platform.environment["HOME"] + "/.config/" + vmBase);
  }
  if (Platform.isWindows) {
    return IOSettings(vmBase: Platform.environment["APPDATA"] + "\\" + vmBase);
  }
  if (Platform.isMacOS) {
    return IOSettings(
        vmBase: Platform.environment["HOME"] +
            "/Library/Application Support/" +
            vmBase);
  }
  throw "Unsupported platform";
}

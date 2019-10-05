import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'settings_io.dart';
import 'settings_vm.dart' as vm;
import 'settings.dart';

Settings createSettings(vmBase) {
  if (!(Platform.isIOS || Platform.isAndroid)) return vm.createSettings(vmBase);
  return IOSettings(futureBase: getApplicationDocumentsDirectory());
}

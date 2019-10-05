# Cross settings

![Pub](https://img.shields.io/pub/v/cross_settings)

Cross platform settings, that is all this is.
If you want to load a settings file, all one needs to do is

```dart
Settings(vmBase:"appName").loadSettings("settingsFile");
```

`vmBase` is only used when ran on non-android/non-ios devices, for places like `~/.config/appName`

enum KeysOfApp { weatherApiKey, appName }

extension TypeExtensionOfKeysOfApp on KeysOfApp {
  String key() {
    switch (this) {
      case KeysOfApp.weatherApiKey:
        return '6f27a7b9512c4882a45162444252101';
      case KeysOfApp.appName:
        return 'Weather App';
    }
  }
}

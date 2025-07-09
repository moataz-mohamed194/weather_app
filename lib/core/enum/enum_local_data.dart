enum LocalDateUsing { weather }

extension TypeExtensionOfLocalDateUsing on LocalDateUsing {
  String text() {
    switch (this) {
      case LocalDateUsing.weather:
        return 'weather';
    }
  }
}

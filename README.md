# Weather App

A cross-platform weather application built with Flutter. This app allows users to search for current weather conditions by city, view weather details, and enjoy a responsive, modern UI. The project demonstrates clean architecture, state management, dependency injection, and offline caching.

## Architecture

This project follows the Clean Architecture pattern:

- **Presentation Layer**: UI widgets, screens, and state management (Provider)
- **Domain Layer**: Entities and repository interfaces
- **Data Layer**: Repository implementations, remote and local data sources
- **Core**: Common utilities, error handling, network, and DI setup

### Key Technologies
- [Flutter](https://flutter.dev/)
- [Provider](https://pub.dev/packages/provider)
- [GetIt](https://pub.dev/packages/get_it)
- [Dio](https://pub.dev/packages/dio)
- [Shared Preferences](https://pub.dev/packages/shared_preferences)
- [ScreenUtil](https://pub.dev/packages/flutter_screenutil)

## Getting Started

### Installation
1. **Clone the repository:**
   ```bash
   git clone https://github.com/moataz-mohamed194/weather_app.git
   cd weather_app
   ```
2. **Install dependencies:**
   ```bash
   flutter pub get
   ```
3. **Install dependencies:**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs 
   ```
4. **Run the app:**
   ```bash
   flutter run
   ```


## License

This project is licensed under the MIT License.

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  final Logger _log = Logger('WeatherProvider');
  WeatherModel? _weatherData;
  String? _displayName;
  final WeatherService _weatherService = WeatherService();
  ThemeMode _themeMode = ThemeMode.system;

  set weatherData(WeatherModel? weather) {
    _weatherData = weather;
    notifyListeners();
  }

  WeatherModel? get weatherData => _weatherData;
  String? get cityName => _displayName ?? _weatherData?.name;
  ThemeMode get themeMode => _themeMode;

  void toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> getWeatherData({required String cityName}) async {
    try {
      _weatherData = await _weatherService.getWeather(cityName: cityName);
      _displayName = null;
      notifyListeners();
    } catch (e) {
      _log.severe('Error fetching weather data: $e');
      _weatherData = null; // Clear data on error
      _displayName = null;
      notifyListeners();
      rethrow; // Re-throw the exception for UI to handle
    }
  }

  Future<void> getWeatherByLocation(
      {required double latitude, required double longitude}) async {
    try {
      _weatherData = await _weatherService.getWeatherByCoordinates(
          latitude: latitude, longitude: longitude);
      _displayName = 'Current Location';
      notifyListeners();
    }
    catch (e) {
      _log.severe('Error fetching weather data by coordinates: $e');
      _weatherData = null; // Clear data on error
      _displayName = null;
      notifyListeners();
      rethrow; // Re-throw the exception for UI to handle
    }
  }
}

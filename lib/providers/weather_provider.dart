import 'package:flutter/cupertino.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherModel? _weatherData;
  String? cityName;
  final WeatherService _weatherService = WeatherService();

  set weatherData(WeatherModel? weather) {
    _weatherData = weather;
    notifyListeners();
  }

  WeatherModel? get weatherData => _weatherData;

  Future<void> getWeatherData({required String cityName}) async {
    try {
      _weatherData = await _weatherService.getWeather(cityName: cityName);
      notifyListeners();
    } catch (e) {
      print('Error fetching weather data: $e');
      _weatherData = null; // Clear data on error
      notifyListeners();
      rethrow; // Re-throw the exception for UI to handle
    }
  }  Future<void> getWeatherByLocation(
      {required double latitude, required double longitude}) async {
    try {
      _weatherData = await _weatherService.getWeatherByCoordinates(
          latitude: latitude, longitude: longitude);
      notifyListeners();
    } catch (e) {
      print('Error fetching weather data by coordinates: $e');
      _weatherData = null; // Clear data on error
      notifyListeners();
      rethrow; // Re-throw the exception for UI to handle
    }
  }
}

import 'package:flutter/material.dart';

class WeatherModel {
  DateTime date;
  double temp;
  double maxTemp;
  double minTemp;
  double feelsLike;
  double humidity;
  double windSpeedKph;
  double visibilityKm;
  double pressure;
  String weatherStateName;
  int chanceOfRain;
  List<HourlyWeather> hourlyForecast;

  WeatherModel({
    required this.date,
    required this.temp,
    required this.maxTemp,
    required this.minTemp,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeedKph,
    required this.visibilityKm,
    required this.pressure,
    required this.weatherStateName,
    required this.chanceOfRain,
    required this.hourlyForecast,
  });

  factory WeatherModel.fromJson(dynamic data) {
    var jsonData = data['forecast']['forecastday'][0]['day'];
    var currentData = data['current'];
    var forecastday = data['forecast']['forecastday'][0];
    List<HourlyWeather> hourlyData = [];
    for (var hourData in forecastday['hour']) {
      hourlyData.add(HourlyWeather.fromJson(hourData));
    }

    return WeatherModel(
      date: DateTime.parse(currentData['last_updated']),
      temp: jsonData['avgtemp_c'],
      maxTemp: jsonData['maxtemp_c'],
      minTemp: jsonData['mintemp_c'],
      feelsLike: currentData['feelslike_c'],
      humidity: currentData['humidity'].toDouble(),
      windSpeedKph: currentData['wind_kph'],
      visibilityKm: currentData['vis_km'],
      pressure: currentData['pressure_mb'],
      weatherStateName: jsonData['condition']['text'],
      chanceOfRain: jsonData['daily_chance_of_rain'],
      hourlyForecast: hourlyData,
    );
  }

  @override
  String toString() {
    return 'temp = $temp  minTemp = $minTemp  date = $date';
  }

  String getImage() {
    if (weatherStateName == 'Sunny' ||
        weatherStateName == 'Clear' ||
        weatherStateName == 'partly cloudy') {
      return 'assets/images/clear.png';
    } else if (weatherStateName == 'Blizzard' ||
        weatherStateName == 'Patchy snow possible' ||
        weatherStateName == 'Patchy sleet possible' ||
        weatherStateName == 'Patchy freezing drizzle possible' ||
        weatherStateName == 'Blowing snow') {
      return 'assets/images/snow.png';
    } else if (weatherStateName == 'Freezing fog' ||
        weatherStateName == 'Fog' ||
        weatherStateName == 'Heavy Cloud' ||
        weatherStateName == 'Mist') {
      return 'assets/images/cloudy.png';
    } else if (weatherStateName == 'Patchy rain possible' ||
        weatherStateName == 'Heavy Rain' ||
        weatherStateName == 'Showers') {
      return 'assets/images/rainy.png';
    } else if (weatherStateName == 'Thundery outbreaks possible' ||
        weatherStateName == 'Moderate or heavy snow with thunder' ||
        weatherStateName == 'Patchy light snow with thunder' ||
        weatherStateName == 'Moderate or heavy rain with thunder' ||
        weatherStateName == 'Patchy light rain with thunder') {
      return 'assets/images/thunderstorm.png';
    } else {
      return 'assets/images/clear.png';
    }
  }

  MaterialColor getThemeColor() {
    if (weatherStateName == 'Sunny' ||
        weatherStateName == 'Clear' ||
        weatherStateName == 'partly cloudy') {
      return Colors.orange;
    } else if (weatherStateName == 'Blizzard' ||
        weatherStateName == 'Patchy snow possible' ||
        weatherStateName == 'Patchy sleet possible' ||
        weatherStateName == 'Patchy freezing drizzle possible' ||
        weatherStateName == 'Blowing snow') {
      return Colors.blue;
    } else if (weatherStateName == 'Freezing fog' ||
        weatherStateName == 'Fog' ||
        weatherStateName == 'Heavy Cloud' ||
        weatherStateName == 'Mist') {
      return Colors.blueGrey;
    } else if (weatherStateName == 'Patchy rain possible' ||
        weatherStateName == 'Heavy Rain' ||
        weatherStateName == 'Showers') {
      return Colors.blue;
    } else if (weatherStateName == 'Thundery outbreaks possible' ||
        weatherStateName == 'Moderate or heavy snow with thunder' ||
        weatherStateName == 'Patchy light snow with thunder' ||
        weatherStateName == 'Moderate or heavy rain with thunder' ||
        weatherStateName == 'Patchy light rain with thunder') {
      return Colors.deepPurple;
    } else {
      return Colors.orange;
    }
  }
}

class HourlyWeather {
  DateTime time;
  double tempC;
  String weatherIcon;

  HourlyWeather({
    required this.time,
    required this.tempC,
    required this.weatherIcon,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      time: DateTime.parse(json['time']),
      tempC: json['temp_c'],
      weatherIcon: json['condition']['icon'],
    );
  }
}




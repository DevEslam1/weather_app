import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_page.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/falling_stars.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOut),
    );

    _fadeController.forward();
    _slideController.forward();
  }

  Future<void> _getCurrentLocationWeather(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location services are disabled.')),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Location permissions are permanently denied, we cannot request permissions.')),
      );
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      final weatherProvider =
          Provider.of<WeatherProvider>(context, listen: false);
      await weatherProvider.getWeatherByLocation(
          latitude: position.latitude, longitude: position.longitude);
      weatherProvider.cityName = 'Current Location';
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error getting location: $e')),
      );
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const textColor = Colors.white;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(''),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: textColor,
        actions: [
          IconButton(
            onPressed: () {
              _getCurrentLocationWeather(context);
            },
            icon: const Icon(Icons.my_location),
            splashRadius: 24,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const SearchPage();
              }));
            },
            icon: const Icon(Icons.search),
            splashRadius: 24,
          ),
        ],
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, child) {
          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0F1419), Color(0xFF1A2332)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              const FallingStars(),
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: weatherProvider.weatherData == null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.cloud_off_outlined,
                                  size: 80, color: textColor.withOpacity(0.5)),
                              const SizedBox(height: 24),
                              const Text(
                                'No Weather Data',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Search for a city to get started',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  color: textColor.withOpacity(0.8),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(24, 100, 24, 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                weatherProvider.cityName ?? 'Unknown',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                '${weatherProvider.weatherData!.date.hour.toString().padLeft(2, '0')}:${weatherProvider.weatherData!.date.minute.toString().padLeft(2, '0')} - Today, ${weatherProvider.weatherData!.date.day}/${weatherProvider.weatherData!.date.month}',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  color: textColor.withOpacity(0.8),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                        weatherProvider.weatherData!.getImage(),
                                        width: 60,
                                        height: 60,
                                        color: Colors.white),
                                    const SizedBox(width: 20),
                                    Text(
                                      '${weatherProvider.weatherData!.temp.toInt()}°',
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 90,
                                        fontWeight: FontWeight.w300,
                                        color: textColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Center(
                                child: Text(
                                  '${weatherProvider.weatherData!.weatherStateName} / Feels like ${weatherProvider.weatherData!.feelsLike.toInt()}°',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    color: textColor.withOpacity(0.8),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              _buildDetailsCard(weatherProvider.weatherData!),
                              const SizedBox(height: 20),
                              _buildHourlyForecast(
                                  weatherProvider.weatherData!.hourlyForecast),
                            ],
                          ),
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDetailsCard(WeatherModel weatherData) {
    final cardColor = Colors.white.withOpacity(0.1);
    const textColor = Colors.white;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildWeatherDetail('Wind',
                  '${weatherData.windSpeedKph.toInt()} km/h', textColor),
              _buildWeatherDetail(
                  'Humidity', '${weatherData.humidity.toInt()}%', textColor),
              _buildWeatherDetail(
                  'Pressure', '${weatherData.pressure.toInt()} hPa', textColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherDetail(String title, String value, Color textColor) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: textColor.withOpacity(0.8),
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ],
    );
  }

  Widget _buildHourlyForecast(List<HourlyWeather> hourlyForecast) {
    final cardColor = Colors.white.withOpacity(0.1);
    const textColor = Colors.white;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Details',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      hourlyForecast.length > 8 ? 8 : hourlyForecast.length,
                  itemBuilder: (context, index) {
                    final hourly = hourlyForecast[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: _buildHourlyCard(
                        time:
                            '${hourly.time.hour.toString().padLeft(2, '0')}:00',
                        iconUrl: hourly.weatherIcon,
                        temp: hourly.tempC.toInt().toString(),
                        textColor: textColor,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHourlyCard(
      {required String time,
      required String iconUrl,
      required String temp,
      required Color textColor}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          time,
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              color: textColor.withOpacity(0.8),
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Image.network('https:$iconUrl', width: 32, height: 32),
        const SizedBox(height: 8),
        Text(
          '$temp°',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ],
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_page.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/falling_stars.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(''),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor:
            theme.brightness == Brightness.light ? Colors.black : Colors.white,
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
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.surface,
                      theme.colorScheme.surface.withValues(alpha: 200 / 255)
                    ],
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
                                  size: 80,
                                  color:
                                      textColor.withValues(alpha: 128 / 255)),
                              const SizedBox(height: 24),
                              Text(
                                'No Weather Data',
                                style: theme.textTheme.headlineSmall
                                    ?.copyWith(color: textColor),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Search for a city to get started',
                                style: theme.textTheme.bodyLarge?.copyWith(
                                    color:
                                        textColor.withValues(alpha: 204 / 255)),
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
                                (weatherProvider.cityName ?? 'Unknown'),
                                style: theme.textTheme.headlineMedium?.copyWith(
                                    color: textColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${weatherProvider.weatherData!.date.hour.toString().padLeft(2, '0')}:${weatherProvider.weatherData!.date.minute.toString().padLeft(2, '0')} - Today, ${weatherProvider.weatherData!.date.day}/${weatherProvider.weatherData!.date.month}',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                    color:
                                        textColor.withValues(alpha: 204 / 255),
                                    fontWeight: FontWeight.w500),
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
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      '${weatherProvider.weatherData!.temp.toInt()}°',
                                      style: theme.textTheme.displayLarge
                                          ?.copyWith(
                                              color: textColor,
                                              fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              Center(
                                child: Text(
                                  '${weatherProvider.weatherData!.weatherStateName} / Feels like ${weatherProvider.weatherData!.feelsLike.toInt()}°',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                      color: textColor.withValues(
                                          alpha: 204 / 255),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              const Spacer(),
                              _buildDetailsCard(
                                  weatherProvider.weatherData!, theme),
                              const SizedBox(height: 20),
                              _buildHourlyForecast(
                                  weatherProvider.weatherData!.hourlyForecast,
                                  theme),
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

  Widget _buildDetailsCard(WeatherModel weatherData, ThemeData theme) {
    final cardColor = theme.colorScheme.surface.withValues(alpha: 50 / 255);
    final textColor = theme.colorScheme.onSurface;

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
              _buildWeatherDetail(
                  'Wind',
                  '${weatherData.windSpeedKph.toInt()} km/h',
                  textColor,
                  Icons.air,
                  theme),
              _buildWeatherDetail(
                  'Humidity',
                  '${weatherData.humidity.toInt()}%',
                  textColor,
                  Icons.water_drop,
                  theme),
              _buildWeatherDetail(
                  'Pressure',
                  '${weatherData.pressure.toInt()} hPa',
                  textColor,
                  Icons.speed,
                  theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherDetail(String title, String value, Color textColor,
      IconData icon, ThemeData theme) {
    return Column(
      children: [
        Icon(
          icon,
          color:
              theme.brightness == Brightness.dark ? Colors.white : Colors.black,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          title,
          style: theme.textTheme.bodySmall?.copyWith(
              color: textColor.withValues(alpha: 204 / 255),
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.bodyLarge
              ?.copyWith(color: textColor, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildHourlyForecast(
      List<HourlyWeather> hourlyForecast, ThemeData theme) {
    final cardColor = theme.colorScheme.surface.withValues(alpha: 50 / 255);
    final textColor = theme.colorScheme.onSurface;

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
              Text(
                'Details',
                style: theme.textTheme.titleMedium
                    ?.copyWith(color: textColor, fontWeight: FontWeight.bold),
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
                        theme: theme,
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
      required Color textColor,
      required ThemeData theme}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          time,
          style: theme.textTheme.bodySmall?.copyWith(
              color: textColor.withValues(alpha: 204 / 255),
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Image.network(
          'https:$iconUrl',
          width: 40,
          height: 40,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.broken_image,
              size: 40,
              color: theme.brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            );
          },
        ),
        const SizedBox(height: 8),
        Text(
          '$temp°',
          style: theme.textTheme.bodyLarge
              ?.copyWith(color: textColor, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

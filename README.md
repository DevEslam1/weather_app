<p align="center">
  <img width="300" height="300" alt="app_icon" src="https://github.com/user-attachments/assets/92c95fab-8ee7-4b8d-b191-05070b12be83" />

</p>
<h1 align="center">Weather App</h1>

A Flutter project to display weather information, designed with a sleek, modern space theme.

## 🌟 Features

- **🌌 Space-Themed Design:** Immerse yourself in a visually stunning space theme with a dynamic falling stars background and a consistent dark-mode aesthetic.
- **📱 Modern UI:** The app features a clean, modern design with a focus on readability and a great user experience.
- **✒️ Poppins Font:** The app uses the beautiful Poppins font, created by the Indian Type Foundry.
- **🎨 Theme-Aware UI:** The application fully supports light and dark modes, adapting its text, icons, and various UI elements to match your device's theme for an optimal viewing experience.
- **🌦️ Enhanced Weather Details:** Get comprehensive weather information at a glance, including:
    - 🌡️ **Current Temperature** with local asset weather icon
    - 🌡️ **Maximum Temperature**
    - 🌡️ **Minimum Temperature**
    - 💧 **Humidity**
    - 💨 **Wind Speed**
    - 🔌 **Pressure**
    - ❄️ **Chance of Rain**
- **⏰ Hourly Forecast:** View real-time hourly forecast with live API weather icons for the next 8 hours.
- **🎯 Smart Weather Icons:** 
    - Main display uses local asset icons based on weather conditions
    - Hourly forecast cards display live API weather icons
- **🔍 City Search:** Search for weather information by city name with autocomplete support.
- **📍 Current Location Weather:**
    - Automatically fetch weather data for your current GPS location.
    - Includes a convenient "Get Current Location" button on the home screen and search page.
- **🌐 Real-time Data:** Powered by WeatherAPI.com for accurate, up-to-date weather information.

## Screenshots
<p align="center">
  <img width="200"  alt="Screenshot_1768929710" src="https://github.com/user-attachments/assets/764c89b0-418f-48d6-ade3-bd949da6ed44" />
<img width="200" alt="Screenshot_1768929716" src="https://github.com/user-attachments/assets/6258fe0c-6ae0-4294-a499-cf8722ff618e" />
<img width="200" alt="Screenshot_1768930389" src="https://github.com/user-attachments/assets/0a9dd4e2-af71-465d-aa28-973a7abe4856" />
<img width="200" alt="Screenshot_1768930372" src="https://github.com/user-attachments/assets/9090bedc-ee27-47ae-aed6-5f964f9496f8" />
</p>

## 🛠️ Tech Stack

- **Flutter:** The UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- **Dart:** The programming language used for building Flutter apps.
- **Provider:** For state management and reactive UI updates.
- **Geolocator:** To get the current location of the device.
- **Google Fonts:** To use the Poppins font.
- **HTTP:** For making API requests to WeatherAPI.com.
- **WeatherAPI.com:** Real-time weather data API with comprehensive weather conditions and icons.

<details>
<summary>🚀 Getting Started</summary>

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
</details>

<details>
<summary>⚙️ Setup for Location Services</summary>

To enable the current location feature, you need to add specific permissions for Android and iOS.

**For Android:**
Add the following to `android/app/src/main/AndroidManifest.xml` within the `<manifest>` tag:
```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

**For iOS:**
Add the following to `ios/Runner/Info.plist` within the `<dict>` tag:
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs access to location when in use.</string>
```
</details>

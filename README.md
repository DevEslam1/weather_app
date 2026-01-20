<p align="center">
  <img src="https://github.com/user-attachments/assets/38f559c3-6c96-421e-a053-c8ee533cc105" width="200" />
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
  <img src="https://github.com/user-attachments/assets/3fde0c51-7033-4703-b095-e544e2f2bf41" width="200" />
  <img src="https://github.com/user-attachments/assets/38f559c3-6c96-421e-a053-c8ee533cc105" width="200" />
  <img src="https://github.com/user-attachments/assets/3c141c4a-4e8c-4e16-9706-eb0c380736e9" width="200" />
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
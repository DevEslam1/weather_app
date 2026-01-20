# Weather App

A Flutter project to display weather information.

## Features

- **Space-Themed Design:** Immerse yourself in a visually stunning space theme with a dynamic falling stars background and a consistent dark-mode aesthetic.
- **Modern UI:** The app features a clean, modern design with a focus on readability and a great user experience.
- **Poppins Font:** The app uses the beautiful Poppins font, created by the Indian Type Foundry.
- **Theme-Aware UI:** The application fully supports light and dark modes, adapting its text, icons, and various UI elements to match your device's theme for an optimal viewing experience.
- **Enhanced Weather Details:** Get comprehensive weather information at a glance, including:
    - Maximum Temperature
    - Minimum Temperature
    - Humidity
    - Wind Speed
- **Intuitive Weather Icons:** Clear and descriptive icons are displayed alongside weather data points, making it easier to understand the forecast.
- **Current Location Weather:**
    - Automatically fetch weather data for your current GPS location.
    - Includes a convenient "Get Current Location" button on the home screen.

## Screenshots
<p align="center">
  <img src="https://github.com/user-attachments/assets/3fde0c51-7033-4703-b095-e544e2f2bf41" width="200" />
  <img src="https://github.com/user-attachments/assets/38f559c3-6c96-421e-a053-c8ee533cc105" width="200" />
  <img src="https://github.com/user-attachments/assets/3c141c4a-4e8c-4e16-9706-eb0c380736e9" width="200" />
</p>

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Setup for Location Services

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

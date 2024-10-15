# Google Maps Tracking Project 🌏📌📍

This project is a Flutter-based application that integrates Google Maps to provide an interactive map display with real-time tracking functionality. It’s designed to monitor and visualize movement, making it ideal for applications like delivery tracking, location sharing, or fleet management.

## Features

- **Interactive Map Display**: A dynamic map with multiple layer options and easy navigation.
- **Real-Time Tracking**: Accurate tracking of entities with smooth, real-time updates on the map.
- **Custom Markers**: Use custom markers for a clear representation of tracked entities.
- **Map Controls**: Zoom, pan, and other map controls enhance the user experience.
- **Cross-Platform**: Developed with Flutter, ensuring compatibility on both Android and iOS.

## Technologies Used

- **[Google Maps API](https://developers.google.com/maps/documentation)**: For map rendering and location tracking.
- **[Flutter](https://flutter.dev/)**: The framework used for building the app.
- **Dart**: The programming language for Flutter applications.

## Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- A Google Maps API Key. You can obtain one from the [Google Cloud Console](https://console.cloud.google.com/).

### Installation

1. **Clone the Repository**:
    ```bash
    git clone https://github.com/HusseinMohamed99/GoogleMapsAndTracking.git
    cd your-repo-name
    ```

2. **Install Dependencies**:
    ```bash
    flutter pub get
    ```

3. **Add Your Google Maps API Key**:
   - Open the `android/app/src/main/AndroidManifest.xml` file and add your API key:
     ```xml
     <meta-data
         android:name="com.google.android.geo.API_KEY"
         android:value="YOUR_API_KEY_HERE"/>
     ```
   - For iOS, open `ios/Runner/AppDelegate.swift` and set your API key:
     ```swift
     GMSServices.provideAPIKey("YOUR_API_KEY_HERE")
     ```

4. **Run the App**:
    ```bash
    flutter run
    ```

## Usage

- Open the app to view the map.
- Use the controls to navigate and zoom.
- Observe real-time tracking as entities move on the map.


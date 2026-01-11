# SafeTrack – Child Location & Safe Zone Monitoring App

![Flowchart](https://raw.githubusercontent.com/LUwUcifer/Child_Tracker/refs/heads/main/poster3.png)

## Overview

SafeTrack is a real‑time child location tracking and safe zone alerting application designed to help parents monitor the whereabouts of their children and receive alerts when they enter or exit predefined regions (like home, school, parks). The app uses Mapbox for map visualization and geofencing, and is built with Flutter to support cross‑platform deployment on iOS and Android.

### Features

1. ️ Real‑Time Location Tracking – View your child’s current location on an interactive map.
2.  Safe Zone Monitoring – Define geofenced areas with custom radii.
3.  Zone Entry/Exit Alerts – Get notifications whenever predefined zone boundaries are crossed.
4.  User‑Friendly Interface – Simple and intuitive setup for everyday use.
 
### How It Works

#### → Parents define safe zones in the app (home, school, etc.).

#### → The child’s device periodically reports its GPS coordinates.

#### → The app checks the child’s location relative to safe zones and triggers alerts on exit/enter.

Note: Mapbox provides map rendering and geofencing logic. Firebase will be introduced for user authentication and backend services.

![Interface](https://raw.githubusercontent.com/LUwUcifer/Child_Tracker/refs/heads/main/poster2.png)

## Tech Stack
UI - Flutter

Maps & Georeferencing - Mapbox API

Backend - Firebase

Platforms - iOS, Android

Languages - Dart, Arduino

## Getting Started
#### Clone the repository & Executing
```git
git clone https://github.com/LUwUcifer/Child_Tracker.git
cd Child_Tracker
flutter pub get
// Add Mapbox API key
flutter run android
```

### Details of the workflow and device 

![Poster](https://raw.githubusercontent.com/LUwUcifer/Child_Tracker/refs/heads/main/poster.png)


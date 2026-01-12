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

### Further Functioning Details

#### How it will handle more users

As the application relies on highly accurate and scalable APIs like MapBox and Firebase, Scalability will only be a question of Funding

We intend to make the tracking device a one-time purchase and a minimal subscription fee to the app monthly to cover costs

#### How the system will handle growth and avoid failures

Below is a list for how the system will deal with related failures:

1. Failure of Firebase: While firebase will store unique ID data for every user, it is primarily for sync and data stored locally on the device will be used by the application

2. Failure of Mapbox API: We will be implementing a fallback API of OpenStreetView to ensure the proper functioning in case of failure of map services, it hasn't been used as the primary tool as Mapbox API also provides details of relevant information such as traffic/accidents etc.

Since these are the primary tools used by our application and are replacable in a situtation of emergency, our app is not failure-prone and works under all circumstances.

#### Team Member contribution

Kushagra Saxena - Application UI and Data Tracking

Aryan Boro - Mapbox API configuration

Daksh Yadav - Research on Unit Economics of the application and Hardware requirements

Shreyansh Yadav - Designs, Mockups, and Presentation

#### Research Notes
1. Family360, AirDroid Location Tracker, Find My Kids
2. Merry, Krista, and Pete Bettinger. "Smartphone GPS accuracy study in an urban environment." PloS one 14.7 (2019): e0219890.
3. Wing, Michael G., Aaron Eklund, and Loren D. Kellogg. "Consumer-grade global positioning system (GPS) accuracy and reliability." Journal of forestry 103.4 (2005): 169-173.
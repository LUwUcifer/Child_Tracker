# SafeTrack – Child Location & Safe Zone Monitoring App
Overview
SafeTrack is a mobile application designed to provide parents with real-time location tracking of their children and monitor whether they have left predefined safe zones. The app integrates Mapbox for map visualization and geofencing, built using Flutter for cross-platform compatibility.
![Poster](https://github.com/LUwUcifer/Child_Tracker/blob/main/poster.png)

# Features
Real-Time Location Tracking: View your child's current location on an interactive map.

Safe Zone Monitoring: Predefine safe zones such as home, school, or parks with custom radius settings.

Zone Alerts: Receive notifications when a child enters or exits a designated safe zone.

Mapbox Integration: High-quality map rendering, geocoding, and geofencing capabilities.

User-Friendly Interface: Simple and intuitive design for easy setup and daily use.

Screens
Tracking Screen: Displays the child’s live location and movement history.

Map Screens: Interactive map showing safe zones and the child’s current position.

Safe Zones Screen: Manage and customize safe zones (add, edit, delete).

Safe Zone Example
Home: 300m radius

School: 250m radius

Park: 200m radius

![Interface](https://github.com/LUwUcifer/Child_Tracker/blob/main/poster2.png)

# Technology Stack
Flutter: Frontend development

Mapbox API: Maps, directions, and geofencing

Firebase: Planned for backend services (see Future Plans)

![Flowchart](https://github.com/LUwUcifer/Child_Tracker/blob/main/poster3.png)

# Future Plans
Firebase Integration for Centralized Login System
We plan to integrate Firebase Authentication to provide a secure, centralized login system. This will allow:

User registration and login via email or social providers

Secure storage of user profiles and child information

Encrypted data transmission between the app and Firebase

Role-based access for multiple guardians per child

Accessible Wearable Device Integration
To enhance safety and convenience, we are developing support for an affordable, child-friendly wearable device that will:

Sync directly with the SafeTrack app via Bluetooth and cellular connectivity

Include a panic button for the child to send an alert

Offer long battery life and durable, waterproof design

Provide location updates even in areas with limited phone connectivity

Allow parents to set safe zone boundaries and receive breach alerts directly from the wearable

# Additional Upcoming Features
History Logs: View timeline of location history and zone entries/exits

Multi-Child Support: Track multiple children from a single account

Custom Notifications: Set different alert tones for different zones

Offline Mode: Basic tracking and zone monitoring without internet

Emergency Contacts: Quick access to trusted contacts in case of zone breach

# Getting Started
Clone the repository

Install Flutter SDK and dependencies

Add Mapbox API key to configuration

Run the app on an emulator or physical device

# Setup Instructions
Obtain a Mapbox access token from Mapbox Studio

Configure safe zones via the app interface

Ensure location permissions are enabled on the device

# Disclaimer
SafeTrack is intended for parental supervision and safety purposes only. Users are responsible for complying with local privacy laws and obtaining consent where required.
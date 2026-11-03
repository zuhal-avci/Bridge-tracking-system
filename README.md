# Bridge Tracking System

A Flutter-based mobile application developed during an internship at Bursa Metropolitan Municipality to digitize bridge inventory management and facilitate the recording, viewing, and updating of bridge information.

## Project Overview

The Bridge Tracking System enables authorized users to manage bridge records through a mobile application. Users can register new bridges, store their technical information, view existing records by district, and update bridge details when necessary.

## Features

- **District-Based Bridge Listing:** Select a district and view the bridges registered in that district.
- **Bridge Registration:** Add new bridges by entering their name, construction date, photograph, and location.
- **Map-Based Location Selection:** Retrieve and record bridge locations using map services.
- **Technical Information Management:** Select and save various technical characteristics of each bridge through dedicated form fields.
- **Bridge Information Updates:** Edit and update previously registered bridge records.
- **Photo Documentation:** Associate photographs with bridge records.

## Technologies Used

- Flutter
- Dart
- Hive
- Geolocator

## Application Workflow

1. Select a district from the main screen.
2. View the bridges registered in the selected district.
3. Add a new bridge or select an existing bridge.
4. Enter bridge details, including its name, photograph, construction date, and location.
5. Select the relevant technical characteristics.
6. Save the bridge record.
7. Update the information whenever necessary.

## Installation and Setup

### Prerequisites

- Flutter SDK
- Dart SDK
- Android Studio or Visual Studio Code

### Clone the Repository

```bash
git clone https://github.com/zuhal-avci/Bridge-tracking-system.git
cd Bridge-tracking-system
```

### Install Dependencies

```bash
flutter pub get
```

### Run the Application

```bash
flutter run
```

## Purpose

The project aims to simplify bridge inventory management by providing a centralized digital environment for recording, accessing, and maintaining bridge information.

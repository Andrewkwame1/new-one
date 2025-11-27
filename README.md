# Attendance App

An intelligent, cross-platform attendance management system built with Flutter and Firebase. This application streamlines the process of tracking attendance for both teachers and students using modern technologies like QR codes and geofencing.

## Project Overview

This application provides a seamless and secure way to manage class attendance.

- **Teachers** can create classes, generate unique QR codes for attendance sessions, define a geofence for location validation, and view detailed attendance history for each student.
- **Students** can view their enrolled classes, mark their attendance by scanning a QR code, and check their attendance history for each class.

The app is designed with a clean, modern interface and is built to be scalable and maintainable.

---

## Table of Contents

- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Project Requirements](#project-requirements)
  - [Installation and Setup](#installation-and-setup)
  - [Running the Application](#running-the-application)
- [Project Structure](#project-structure)
- [Key Features](#key-features)

---

## Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

Before you begin, ensure you have the following installed on your system:

- **Flutter SDK:** The project is built with Flutter 3.x. Ensure your Flutter version is compatible. You can find installation instructions on the [official Flutter website](https://flutter.dev/docs/get-started/install).
- **IDE:** Android Studio or Visual Studio Code (recommended).
- **Firebase CLI:** Required for connecting the app to your Firebase project. Install it globally by running:
  ```shell
  npm install -g firebase-tools
  ```

### Project Requirements

To ensure all features of the application function correctly, you must configure the following:

#### 1. SDK Version

- **Dart SDK:** The project requires a Dart SDK version of `^3.9.0` or higher, as defined in `pubspec.yaml`.

#### 2. Firebase Services Configuration

In your [Firebase Console](https://console.firebase.google.com/), you must create a new project and enable the following services:

- **Firebase Authentication:**
  - Go to **Authentication > Sign-in method**.
  - Enable the **Email/Password** provider. This is required for the user login system.
- **Cloud Firestore:**
  - Go to **Firestore Database** and create a new database.
  - Start in **production mode** for more secure rules, or **test mode** for initial development. This is essential for storing all application data (users, classes, attendance).

#### 3. Platform-Specific Permissions (Crucial for Mobile)

To use QR code scanning and geofence validation, you must add the following permissions to the native mobile configuration files.

- **For Android:**
  Add the following lines to `android/app/src/main/AndroidManifest.xml`:
  ```xml
  <uses-permission android:name="android.permission.CAMERA" />
  <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
  <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
  ```

- **For iOS:**
  Add the following keys and descriptions to `ios/Runner/Info.plist`:
  ```xml
  <key>NSCameraUsageDescription</key>
  <string>This app needs camera access to scan QR codes for attendance.</string>
  <key>NSLocationWhenInUseUsageDescription</key>
  <string>This app needs location access to verify your position for attendance.</string>
  <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
  <string>This app needs location access to verify your position for attendance.</string>
  ```

#### 4. Hardware Requirements

- **Physical Device:** A physical smartphone (iOS or Android) is highly recommended for testing full functionality.
- **Camera:** Required for scanning QR codes.
- **GPS:** Required for the geofence and location validation features.

### Installation and Setup

1.  **Clone the Repository:**
    ```shell
    git clone <your-repository-url>
    cd <project-directory>
    ```

2.  **Connect to Firebase:**
    - Log in to Firebase using the CLI:
      ```shell
      firebase login
      ```
    - Configure the project with your Firebase account. This command will guide you through selecting a Firebase project and will generate the `lib/firebase_options.dart` file needed to connect your app.
      ```shell
      flutterfire configure
      ```

3.  **Install Dependencies:**
    Fetch all the required packages from `pubspec.yaml`:
    ```shell
    flutter pub get
    ```

4.  **Run Code Generation:**
    The project uses code generation for routing and state management. Run this command to generate the necessary files. This is also important to run after making changes to providers or models.
    ```shell
    dart run build_runner build --delete-conflicting-outputs
    ```

### Running the Application

Once the setup is complete, you can run the app on a connected device or emulator.

1.  **Select a Device:**
    Use `flutter devices` to see a list of available devices.

2.  **Run the App:**
    ```shell
    flutter run
    ```
    To run on a specific device (e.g., Chrome for web), use:
    ```shell
    flutter run -d chrome
    ```

---

## Project Structure

The project follows a feature-first architectural approach to keep the codebase organized and scalable.

```
lib
├── api/                  # API service layer for Firebase interactions
├── models/               # Data models (e.g., User, Class, Attendance)
├── providers/            # Riverpod providers for state management
├── routing/              # GoRouter configuration for navigation
├── screens/              # UI screens organized by feature
│   ├── auth/
│   ├── student/
│   └── teacher/
├── shared_widgets/       # Reusable widgets across the app
└── main.dart             # Application entry point
```

---

## Key Features

- **Dual User Roles:** Separate interfaces and logic for Teachers and Students.
- **Secure Authentication:** Email and password login managed by Firebase Auth.
- **Class Management:** Teachers can create, view, and manage their classes.
- **QR Code Attendance:** Teachers generate time-sensitive QR codes for each attendance session.
- **Geofence Validation:** Attendance is only valid if the student is within a teacher-defined geographical area.
- **Real-time Attendance Tracking:** Attendance status updates instantly.
- **Historical Data:** Both teachers and students can view detailed attendance history.
- **Cross-Platform:** A single codebase for Android, iOS, and Web.

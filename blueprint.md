# Project Blueprint

## Overview

This document outlines the architecture, features, and implementation details of the Face Recognition-Based Attendance System. The application is designed to provide a seamless and secure attendance experience for both teachers and students, leveraging QR codes, geolocation, and face recognition.

## Implemented Features

### Core Functionality

*   **Authentication System:** A redesigned, modern authentication screen with a gradient background and styled buttons.
*   **Teacher Dashboard:** A redesigned, card-based interface for managing classes and viewing student counts.
*   **Student Dashboard:**
    *   View a list of active class sessions.
    *   Check-in for a session by scanning a QR code or using a direct link.
    *   View personal attendance history.
*   **Session Management:**
    *   Each session is protected by a geofence (defined by latitude, longitude, and radius).
    *   Automatic generation of unique QR codes and shareable links for each session.
    *   Sessions automatically expire and close based on their defined schedule.
*   **Attendance Recording:**
    *   **Geolocation Verification:** The system captures the student's GPS location and validates it against the session's geofence using the Haversine formula.
    *   **Face Recognition:** The system uses the device's webcam to capture the student's face and verifies their identity. A fallback mechanism is in place for situations where face detection fails.
    *   **Secure Check-in:** Attendance records are created with a student ID, session ID, timestamp, location coordinates, and face data, ensuring a verifiable and secure check-in.
*   **Real-time Updates:**
    *   Teachers can monitor live attendance lists as students check in.
    *   Session statuses are tracked and updated in real-time.

### Technical Implementation

*   **UI/UX:**
    *   Modern, responsive, and mobile-first design based on Material Design 3.
    *   A clean and elegant aesthetic with a teal and gray color scheme.
    *   Uses the "Lora" font for sophisticated typography.
*   **State Management:** The application employs the Reflex State pattern for predictable and maintainable state management.
*   **QR Code Generation:** The `qrcode` library is used for generating session-specific QR codes.
*   **Face Recognition:** The `face_recognition` library is integrated for identity verification.
*   **Geolocation:** The browser's Geolocation API is used to capture student location for validation.

## UI Verification Phase

The following user flows have been successfully tested and verified:

*   Teacher login and dashboard view.
*   Class detail page and session creation workflow.
*   Session detail page displaying the QR code and live attendance data.
*   Student check-in process, including location capture and face recognition.

## Current Task: Redesign Student's Home Screen

*   **Goal:** To create a more engaging, informative, and user-friendly dashboard for students.
*   **Steps:**
    1.  Implement a card-based layout to display the student's enrolled classes.
    2.  Each card will prominently display the class name.
    3.  Include a clear call-to-action on each card for students to join a session or mark their attendance.
    4.  Enhance the overall visual design to be consistent with the modern look of the teacher dashboard.

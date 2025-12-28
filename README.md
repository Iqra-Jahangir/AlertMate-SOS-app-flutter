**# AlertMate-SOS**

AlertMate is a cross-platform mobile safety application built using Flutter.
The app is designed to help users quickly send SOS alerts with their real-time location to emergency contacts during unsafe situations

**Project Overview**

AlertMate addresses the growing need for personal safety, especially for students, travelers, and individuals who may find themselves in emergency situations.
With a simple and intuitive interface, users can:
Store emergency contacts locally
Send SOS alerts with live location
Quickly contact trusted people when in danger

**Purpose**

To provide a lightweight and user-friendly safety application that assists users in quickly contacting trusted individuals during emergencies.

**Target Audience**
University students
Working professionals
Travelers
Individuals concerned about personal safety

**Key Features**

Live Location Access (GPS using Geolocator)
SOS Alert System
Quick Call & SMS to Emergency Contacts
Local Storage using SQLite
Clean & Responsive UI
Persistent Contacts (saved even after app restart)

**Team & Collaboration**

This project was developed as a pair project following proper GitHub collaboration practices.
Both contributors actively committed code
Version control used throughout development
Clear commit history maintained

**Working Flow of the App**
Splash Screen: Displays app logo and handles initial navigation
Main Screen: Bottom navigation controller
Home Screen: SOS activation interface
Contacts Screen: Manage emergency contacts
Message Contacts Screen: Displays contacts for messaging
Safety Tips Screen: Shows safety guidance
Live Map Screen: Displays real-time location
Report Screen: Incident reporting interface
More Screen: Additional app options

**Documentation**
Included:
Project proposal
Architecture explanation
API & service usage
User manual
Screenshots & UI explanation

**Academic Compliance**
This project fulfills all course requirements:
Cross-platform mobile development
Local storage
Mobile-specific features (GPS, SMS)
Clean UI/UX
GitHub collaboration

**Application Architecture**

📁 lib/

📁 data/
emergency_numbers_data.dart
safety_tips_data.dart

📁 models/
contact.dart
emergency_number.dart
safety_tip.dart

📁 screens/
contacts_screen.dart
home_screen.dart
live_map_screen.dart
main_screen.dart
message_contacts_screen.dart
more_screen.dart
report_screen.dart
safety_tips_screen.dart
splash_screen.dart

📁 services/
alert_service.dart
database_helper.dart
location_service.dart
sos_service.dart

📁 utils/
colors.dart
constants.dart

📁 widgets/
action_button.dart
contact_card.dart
safety_tip_card.dart
sos_button.dart

📄 Root Files
main.dart

**Packages used**
geolocator
sqflite
path
url_launcher
flutter_map
latlong2

**UI/UX Design Considerations**
Minimal navigation
High-contrast buttons for emergencies
Clear icons and labels
Fast access to SOS feature

**Testing & Compatibility**
Tested on:
Android Emulator
Chrome (Flutter Web – limited features)
Designed for both Android & iOS compatibility

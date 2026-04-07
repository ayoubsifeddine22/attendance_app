# Attendance App - QR Code Based Attendance System

A modern Flutter application for tracking attendance using QR codes. Teachers generate QR codes for subjects, and students scan them to mark their attendance.

## Features

- **Role-Based Authentication** - Separate student and teacher accounts with secure Firebase Auth
- **QR Code Generation** - Teachers create subjects and generate unique QR codes
- **QR Code Scanning** - Students scan QR codes using device camera to mark attendance
- **Duplicate Prevention** - Prevents marking the same subject twice on the same day
- **Attendance History** - Students can view their attendance records grouped by subject
- **Teacher Dashboard** - Teachers can view student attendance statistics
- **Cloud Database** - All data stored securely in Firebase Firestore

## Tech Stack

| Component | Technology |
|-----------|-----------|
| Language | Dart |
| Framework | Flutter |
| Database | Firebase Firestore |
| Authentication | Firebase Auth |
| QR Generation | qr_flutter |
| QR Scanning | mobile_scanner |

## Architecture

The app uses a **Model-Service-Screen** pattern:

- **Models** - Data structures (Subject, AttendanceRecord) with serialization
- **Services** - Business logic layer (AuthService, SubjectService, AttendanceService)
- **Screens** - UI layer (8 different screens for different functionality)
- **Themes** - Centralized design system

## Project Structure

```
lib/
├── main.dart                          # App entry point
├── models/
│   ├── subject.dart                   # Subject model
│   └── attendance_record.dart         # Attendance record model
├── services/
│   ├── auth_service.dart              # Authentication logic
│   ├── subject_service.dart           # Subject CRUD operations
│   └── attendance_service.dart        # Attendance recording and queries
├── screens/
│   ├── login_screen.dart              # Login page
│   ├── signup_screen.dart             # Registration page
│   ├── student_home_screen.dart       # Student dashboard
│   ├── teacher_home_screen.dart       # Teacher dashboard
│   ├── qr_generator_screen.dart       # QR code generation
│   ├── qr_scanner_screen.dart         # QR code scanning
│   ├── attendance_history_screen.dart # Student attendance history
│   └── teacher_attendance_screen.dart # Teacher attendance view
├── themes/
│   └── app_theme.dart                 # Design system and styling
└── firebase_options.dart              # Firebase configuration
```

## Installation

### Prerequisites

- Flutter SDK (latest stable)
- Firebase project set up
- Android SDK / iOS deployment target

### Setup

1. Clone the repository
```bash
git clone https://github.com/ayoubsifeddine22/attendance_app.git
cd attendance_app
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

## How It Works

### Student Workflow
1. Sign up or log in as a student
2. From home screen, tap "Scan QR Code"
3. Point camera at teacher's QR code
4. Attendance marked automatically
5. View attendance history grouped by subject

### Teacher Workflow
1. Sign up or log in as a teacher
2. From home screen, tap "Generate QR Codes"
3. Add new subjects
4. QR codes are generated automatically
5. Share or display QR codes in class
6. View student attendance statistics

## Key Features Explained

### QR Code Format
Each QR code encodes: `subject_id:subject_name`
- Example: `sub123:Mathematics`
- Enables instant validation without database lookup

### Duplicate Prevention
Before recording attendance, the app checks:
- Student ID matches
- Subject ID matches  
- Timestamp is from today (same day)

If all conditions match an existing record, attendance is rejected.

### Data Storage
- **Users** - Stored in Firestore with email, role, and creation date
- **Subjects** - Created by teachers with unique IDs
- **Attendance** - Records include student, subject, and timestamp

## Security

- Passwords hashed using Firebase Auth (Google infrastructure)
- Role-based access control (students/teachers see different features)
- Database queries filtered by user ID
- Authentication token required for API access

## Future Enhancements

- Offline persistence for attendance marking
- Real-time attendance notifications
- Attendance statistics and reports
- Bulk student import
- QR code expiration and regeneration
- Mobile notifications for teachers

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss proposed changes.

## License

This project is part of an academic assignment.

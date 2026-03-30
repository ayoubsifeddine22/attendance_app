# Quick Start Guide

## 📱 Running the App

### **Prerequisites**
- Flutter SDK installed
- Android SDK/Emulator or physical Android device
- Firebase project created with Firestore and Auth enabled

### **1. Get Dependencies**
```bash
flutter pub get
```

### **2. Run the App**
```bash
flutter run
```

---

## 🧪 Testing Workflow

### **Test Case 1: Teacher Setup**
1. Launch app → Go to "Sign Up"
2. Email: `teacher@test.com`
3. Password: `password123`
4. Role: **Teacher** → Sign up
5. Login with these credentials
6. Click "Generate QR Codes"
7. Add subjects:
   - "Mathematics"
   - "Physics"
   - "Chemistry"
8. QR codes are displayed and ready

### **Test Case 2: Student Attendance**
1. Sign up another account:
   - Email: `student@test.com`
   - Password: `password123`
   - Role: **Student**
2. Login as student
3. Click "Scan Attendance QR Code"
4. Point camera at displayed QR code from teacher's screen
5. Attendance marked ✓
6. Try scanning same code again → "Already marked" message appears

### **Test Case 3: View Records**
**As Teacher:**
1. Go to "View Attendance Records"
2. Select a subject
3. See student email with attendance count

**As Student:**
1. Go to "View Attendance History"
2. See all subjects attended with timestamps

---

## 🔐 Security Notes

- Passwords stored securely by Firebase Auth
- Role-based access enforced (students can't access teacher screens)
- Attendance tied to authenticated user ID
- Firestore security rules can be further restricted

---

## 🐛 Troubleshooting

### **"Camera Permission Denied"**
- Grant camera permission when app requests it
- On Android: Settings → Apps → Attendance App → Permissions → Camera

### **"QR Code Not Scanning"**
- Ensure good lighting
- Hold camera steady at ~15cm from QR code
- QR code must be clearly visible

### **"Attendance Already Marked"**
- This is expected! Students can only mark once per subject per day
- Prevents duplicate attendance

### **Firebase Connection Issues**
- Verify internet connection
- Check Firebase credentials in `firebase_options.dart`
- Ensure Firestore database is in "Start in test mode"

---

## 📊 Database Verification

To verify data is being saved correctly:

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project
3. Navigate to Firestore Database
4. Check collections:
   - `users` → View all registered users
   - `subjects` → View all created subjects
   - `attendance` → View all attendance records

---

## 🎯 Features at a Glance

| Feature | Status | How to Access |
|---------|--------|---------------|
| User Authentication | ✅ | Login/Signup screens |
| Role-Based Access | ✅ | Different home screens |
| QR Generation | ✅ | Teacher → Generate QR Codes |
| QR Scanning | ✅ | Student → Scan Attendance QR |
| Attendance Tracking | ✅ | Teacher → View Records |
| Attendance History | ✅ | Student → View History |
| Duplicate Prevention | ✅ | Auto-checked per day |

---

## 📞 Support

For issues or questions:
1. Check the PROJECT_SUMMARY.md for detailed documentation
2. Review error messages in app
3. Check Firebase console for data issues
4. Verify camera permissions on device

---

**Happy Testing! 🎉**

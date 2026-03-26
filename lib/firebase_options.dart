import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA-YFnxk36IwX07OZ2DcRj3pWyUbZpn1To',
    appId: '1:733501941870:android:3975917a42a4346f9b1e7f',
    messagingSenderId: '733501941870',
    projectId: 'attendanceapp-db97a',
    storageBucket: 'attendanceapp-db97a.firebasestorage.app',
  );

  static const FirebaseOptions currentPlatform = android;
}

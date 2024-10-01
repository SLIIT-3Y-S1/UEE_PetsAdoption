import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

// ...

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'your-web-api-key',
    appId: 'your-web-app-id',
    messagingSenderId: 'your-web-messaging-sender-id',
    projectId: 'your-project-id',
    authDomain: 'your-auth-domain',
    storageBucket: 'your-storage-bucket',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCIFY4JIfNCWq0_bir7DLt4J-ZanIPoWJM',
    appId: '1:791892164692:android:4e666c01a15bf9c4b8adc1',
    messagingSenderId: 'your-android-messaging-sender-id',
    projectId: 'pawpal-4d1b7',
    storageBucket: 'pawpal-4d1b7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'your-ios-api-key',
    appId: 'your-ios-app-id',
    messagingSenderId: 'your-ios-messaging-sender-id',
    projectId: 'your-project-id',
    storageBucket: 'your-storage-bucket',
    iosClientId: 'your-ios-client-id',
    iosBundleId: 'your-ios-bundle-id',
  );
}

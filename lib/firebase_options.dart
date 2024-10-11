
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;


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
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCScdf9_YXCGyXjoWwWGeONct0Jx2xKfKA',
    appId: '1:791892164692:web:8c5f38a933c2cf87b8adc1',
    messagingSenderId: '791892164692',
    projectId: 'pawpal-4d1b7',
    authDomain: 'pawpal-4d1b7.firebaseapp.com',
    storageBucket: 'pawpal-4d1b7.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCIFY4JIfNCWq0_bir7DLt4J-ZanIPoWJM',
    appId: '1:791892164692:android:d7d9a6297651ce03b8adc1',
    messagingSenderId: '791892164692',
    projectId: 'pawpal-4d1b7',
    storageBucket: 'pawpal-4d1b7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBf5QmZUUnQ71bhzg4T2x_cw8-fU-529ic',
    appId: '1:791892164692:ios:dc5daf08bcfb3271b8adc1',
    messagingSenderId: '791892164692',
    projectId: 'pawpal-4d1b7',
    storageBucket: 'pawpal-4d1b7.appspot.com',
    iosBundleId: 'com.example.pawpal',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBf5QmZUUnQ71bhzg4T2x_cw8-fU-529ic',
    appId: '1:791892164692:ios:dc5daf08bcfb3271b8adc1',
    messagingSenderId: '791892164692',
    projectId: 'pawpal-4d1b7',
    storageBucket: 'pawpal-4d1b7.appspot.com',
    iosBundleId: 'com.example.pawpal',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCScdf9_YXCGyXjoWwWGeONct0Jx2xKfKA',
    appId: '1:791892164692:web:04855328a2ebd71ab8adc1',
    messagingSenderId: '791892164692',
    projectId: 'pawpal-4d1b7',
    authDomain: 'pawpal-4d1b7.firebaseapp.com',
    storageBucket: 'pawpal-4d1b7.appspot.com',
  );
}

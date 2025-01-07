// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyApTLkcd1QtxC0VxCbIClIIdIZNMpQ4_yM',
    appId: '1:74076396934:web:1c6a9d376fd41f7d14e007',
    messagingSenderId: '74076396934',
    projectId: 'chop-online',
    authDomain: 'chop-online.firebaseapp.com',
    storageBucket: 'chop-online.firebasestorage.app',
    measurementId: 'G-EEKM1VVY19',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAqpi300f28I8VwnhDbKGYEgSJknzw1luU',
    appId: '1:74076396934:android:1f0d8ba01e9f507a14e007',
    messagingSenderId: '74076396934',
    projectId: 'chop-online',
    storageBucket: 'chop-online.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC2xYZAmICFk5ShkV-FBl7pCo0CtK1yN0E',
    appId: '1:74076396934:ios:1fd876dbf422127514e007',
    messagingSenderId: '74076396934',
    projectId: 'chop-online',
    storageBucket: 'chop-online.firebasestorage.app',
    iosBundleId: 'com.example.shopOnline',
  );
}

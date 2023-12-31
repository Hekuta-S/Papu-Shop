// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        return macos;
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
    apiKey: 'AIzaSyBucvt0Hy57WFkBHlI3j3-sEZCERnbidRk',
    appId: '1:47782821637:web:14e412229506a5ade7816c',
    messagingSenderId: '47782821637',
    projectId: 'papushoop-bd3f9',
    authDomain: 'papushoop-bd3f9.firebaseapp.com',
    storageBucket: 'papushoop-bd3f9.appspot.com',
    measurementId: 'G-K8LMQRZE2S',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD8yfdXhL8JQw0aDI48nADNxigr4XdWUuw',
    appId: '1:47782821637:android:10523e424607c980e7816c',
    messagingSenderId: '47782821637',
    projectId: 'papushoop-bd3f9',
    storageBucket: 'papushoop-bd3f9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC354gOM7IFPbDv4oCGvrwCPbR8R_oPQNA',
    appId: '1:47782821637:ios:159589a09dd9dac1e7816c',
    messagingSenderId: '47782821637',
    projectId: 'papushoop-bd3f9',
    storageBucket: 'papushoop-bd3f9.appspot.com',
    iosBundleId: 'com.example.eShop',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC354gOM7IFPbDv4oCGvrwCPbR8R_oPQNA',
    appId: '1:47782821637:ios:50f08177abc304cee7816c',
    messagingSenderId: '47782821637',
    projectId: 'papushoop-bd3f9',
    storageBucket: 'papushoop-bd3f9.appspot.com',
    iosBundleId: 'com.example.eShop.RunnerTests',
  );
}

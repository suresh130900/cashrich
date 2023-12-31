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
    apiKey: 'AIzaSyCUlP1izbNA4n0XeIElt3-jguoOHSjNhg0',
    appId: '1:603033200568:web:12de47348a17e21293514d',
    messagingSenderId: '603033200568',
    projectId: 'cashrich-26755',
    authDomain: 'cashrich-26755.firebaseapp.com',
    storageBucket: 'cashrich-26755.appspot.com',
    measurementId: 'G-LB769JF1YQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDcst7uWtNOnmEnzPiwM-tcfD1InJiqGk0',
    appId: '1:603033200568:android:6b46c45b25984f0b93514d',
    messagingSenderId: '603033200568',
    projectId: 'cashrich-26755',
    storageBucket: 'cashrich-26755.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDZUR0Nq1oP3GgFl5g96oys7gGR2HJoq7E',
    appId: '1:603033200568:ios:1d07103d8fa3a1da93514d',
    messagingSenderId: '603033200568',
    projectId: 'cashrich-26755',
    storageBucket: 'cashrich-26755.appspot.com',
    iosBundleId: 'tech.sctechnologies.cashRich',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDZUR0Nq1oP3GgFl5g96oys7gGR2HJoq7E',
    appId: '1:603033200568:ios:5aab964403156c9793514d',
    messagingSenderId: '603033200568',
    projectId: 'cashrich-26755',
    storageBucket: 'cashrich-26755.appspot.com',
    iosBundleId: 'tech.sctechnologies.cashRich.RunnerTests',
  );
}

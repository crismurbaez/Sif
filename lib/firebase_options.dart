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
    apiKey: 'AIzaSyCv9BolV5YmKMk_Jlq0mH7QjQ5lH3G374g',
    appId: '1:595586859924:web:bbe45c92fbf4747b7a0581',
    messagingSenderId: '595586859924',
    projectId: 'sif-1-e621a',
    authDomain: 'sif-1-e621a.firebaseapp.com',
    storageBucket: 'sif-1-e621a.appspot.com',
    measurementId: 'G-R2K22F693Z',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBQqIuljd2nHT_fz-7SKzAL4wpJH20s6Rc',
    appId: '1:595586859924:android:b484f6f1e97fe0fd7a0581',
    messagingSenderId: '595586859924',
    projectId: 'sif-1-e621a',
    storageBucket: 'sif-1-e621a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBTZsSyhY-9peslHoM9hzbccpegioDJt-8',
    appId: '1:595586859924:ios:00607314c301d38a7a0581',
    messagingSenderId: '595586859924',
    projectId: 'sif-1-e621a',
    storageBucket: 'sif-1-e621a.appspot.com',
    iosClientId: '595586859924-1qa8aafne1bn8kpt0hr4o0e6uvvc3c15.apps.googleusercontent.com',
    iosBundleId: 'com.example.sif',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBTZsSyhY-9peslHoM9hzbccpegioDJt-8',
    appId: '1:595586859924:ios:34cc5952337888087a0581',
    messagingSenderId: '595586859924',
    projectId: 'sif-1-e621a',
    storageBucket: 'sif-1-e621a.appspot.com',
    iosClientId: '595586859924-o4ker97sachcbejnr371fshe29i3vdah.apps.googleusercontent.com',
    iosBundleId: 'com.example.sif.RunnerTests',
  );
}

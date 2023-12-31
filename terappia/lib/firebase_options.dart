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
    apiKey: 'AIzaSyB1KH1dmXxsi6WVzaLMPaG3rbVcO1HCI-M',
    appId: '1:252750395319:web:b66206fc65912525a1da32',
    messagingSenderId: '252750395319',
    projectId: 'terappiachat',
    authDomain: 'terappiachat.firebaseapp.com',
    storageBucket: 'terappiachat.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBoVCfxRJlGVnvqI96_2vlQ5H6L45RNzrc',
    appId: '1:252750395319:android:3d9c23473fed09eba1da32',
    messagingSenderId: '252750395319',
    projectId: 'terappiachat',
    storageBucket: 'terappiachat.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBqHoCiz8osUhs3o-8FmJSdb3KOFT6qSpc',
    appId: '1:252750395319:ios:2fa54728b9f03229a1da32',
    messagingSenderId: '252750395319',
    projectId: 'terappiachat',
    storageBucket: 'terappiachat.appspot.com',
    iosBundleId: 'com.example.terappia',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBqHoCiz8osUhs3o-8FmJSdb3KOFT6qSpc',
    appId: '1:252750395319:ios:4be05c8bac8c1bcfa1da32',
    messagingSenderId: '252750395319',
    projectId: 'terappiachat',
    storageBucket: 'terappiachat.appspot.com',
    iosBundleId: 'com.example.terappia.RunnerTests',
  );
}

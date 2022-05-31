// ignore_for_file: unnecessary_const

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import 'settings.dart';
import 'book.dart';
//import 'generated_plugin_registrant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //web-app
  /*
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyB36RdgEfaYp6W595HLE0uhz2ShilysI0E',
    appId: '1:596845297819:web:33e9e8613dc6ced30a063e',
    messagingSenderId: '596845297819',
    projectId: 'laundromate-2e111',
    authDomain: 'laundromate-2e111.firebaseapp.com',
    storageBucket: 'laundromate-2e111.appspot.com',
    measurementId: 'G-TFF30NT03C',
  ));
  */

  //android
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyAUF5vVt8-X2oypuu_h5SWcE7WRs15Y1ig',
    appId: '1:596845297819:android:73649de62b31323d0a063e',
    messagingSenderId: '596845297819',
    projectId: 'laundromate-2e111',
    storageBucket: 'laundromate-2e111.appspot.com',
  ));

  //ios
  /*
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyBfIkm32b_104BnWzf5UrN1y34ZJ5wRcBE',
    appId: '1:596845297819:ios:63fd08299b2e8d350a063e',
    messagingSenderId: '596845297819',
    projectId: 'laundromate-2e111',
    storageBucket: 'laundromate-2e111.appspot.com',
    iosClientId:
        '596845297819-qlp7mf8aoglmpocoqoa4h94ae011njog.apps.googleusercontent.com',
    iosBundleId: 'com.example.laundromate',
  ));
  */

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const HomePage(), routes: <String, WidgetBuilder>{
      '/book': (context) => const LoadDataFromFireBase(),
      '/settings': (context) => const Settings()
    });
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(0, 74, 173, 2),
        body: Center(
            child: Column(children: <Widget>[
          // ignore: avoid_unnecessary_containers
          Container(child: const Image(image: AssetImage('assets/logo.png'))),
          SizedBox(
            width: 280.0,
            height: 50.0,
            child: ElevatedButton(
                child: const Text(
                  'B O O K',
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/book');
                }),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 280.0,
            height: 50.0,
            child: ElevatedButton(
                child: const Text(
                  'S E T T I N G S',
                  style: const TextStyle(
                      fontSize: 20, color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                }),
          )
        ])));
  }
}

// ignore_for_file: unnecessary_const

// import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:core';
import 'globals.dart' as globals;

import 'homescreen.dart';
import 'notificationservice.dart';

final navigatorKey = GlobalKey<NavigatorState>();

bool show = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  navigatorKey;
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

  // await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //   apiKey: 'AIzaSyBfIkm32b_104BnWzf5UrN1y34ZJ5wRcBE',
  //   appId: '1:596845297819:ios:63fd08299b2e8d350a063e',
  //   messagingSenderId: '596845297819',
  //   projectId: 'laundromate-2e111',
  //   storageBucket: 'laundromate-2e111.appspot.com',
  //   iosClientId:
  //       '596845297819-qlp7mf8aoglmpocoqoa4h94ae011njog.apps.googleusercontent.com',
  //   iosBundleId: 'com.example.laundromate',
  // ));

  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();

  final prefs = await SharedPreferences.getInstance();
  show = prefs.getBool('Onboarding') ?? true;
  //globals.appointment = prefs.getString('appointment');
  globals.saveProfile();
  globals.fetchPrefs();

  DocumentSnapshot ds = await FirebaseFirestore.instance
      .collection('LaundryRC4')
      .doc('status')
      .get();
  globals.status = ds.get('status');
  if (globals.status == 1) {
    FirebaseFirestore.instance
        .collection('LaundryRC4')
        .doc('status')
        .set({'status': 0});
    globals.wmPath = 'assets/wm_green.png';
    globals.dPath = 'assets/dryer_red.png';
  }
  if (globals.status == 0) {
    FirebaseFirestore.instance
        .collection('LaundryRC4')
        .doc('status')
        .set({'status': 1});
    globals.wmPath = 'assets/wm_red.png';
    globals.dPath = 'assets/dryer_green.png';
  }
  runApp(const MyApp());
}

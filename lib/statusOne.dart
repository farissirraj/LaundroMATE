// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'book.dart';
// import 'dart:math';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';
// import 'package:intl/intl.dart';
// import 'settings.dart';
// import 'main.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'globals.dart' as globals;

//int status = 0;

checkIfDocExists() async {
  DocumentSnapshot ds = FirebaseFirestore.instance
      .collection('LaundryRC4')
      .doc('status')
      .get() as DocumentSnapshot<Object?>;
  globals.status = ds.get('status');
}

class StatusOne extends StatelessWidget {
  const StatusOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('S T A T U S'),
          backgroundColor: const Color.fromRGBO(0, 74, 173, 2),
        ),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 2),
        body: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 50,
            ),
            SizedBox(
                width: double.infinity,
                height: 200,
                child: Image(image: AssetImage(globals.wmPath))),
            SizedBox(
              width: double.infinity,
              height: 50,
            ),
            SizedBox(
                width: double.infinity,
                height: 200,
                child: Image(image: AssetImage(globals.dPath))),
          ],
        ));
  }
}

//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:core';
//import 'globals.dart';

import 'settings.dart';
import 'book.dart';
import 'statusOne.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const HomePage(), routes: <String, WidgetBuilder>{
      '/book': (context) => const LoadDataFromFireBase(),
      '/settings': (context) => Settings(),
      '/status': (context) => const StatusOne()
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
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                }),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 280.0,
            height: 50.0,
            child: ElevatedButton(
                child: const Text(
                  'S T A T U S',
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/status');
                }),
          )
        ])));
  }
}

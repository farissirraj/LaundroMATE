// ignore_for_file: unnecessary_new, prefer_const_constructors, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'settings.dart';
import 'book.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage(), routes: <String, WidgetBuilder>{
      '/book': (context) => Book(),
      '/settings': (context) => Settings()
    });
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(0, 74, 173, 2),
        body: Center(
            child: Column(children: <Widget>[
          Container(child: Image(image: AssetImage('assets/logo.png'))),
          SizedBox(
            width: 280.0,
            height: 50.0,
            child: ElevatedButton(
                child: Text(
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
          SizedBox(height: 20),
          SizedBox(
            width: 280.0,
            height: 50.0,
            child: ElevatedButton(
                child: Text(
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
          )
        ])));
  }
}





/*
child: Text(
                  'S A V E  |  U P D A T E',
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 255, 255, 255)),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                onPressed: null,
                */
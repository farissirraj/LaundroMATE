// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Status extends StatelessWidget {
  const Status({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('S T A T U S'),
          backgroundColor: const Color.fromRGBO(0, 74, 173, 2),
        ),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 2),
        body: //Center(
            Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 50,
            ),
            SizedBox(
                width: double.infinity,
                height: 200,
                child: Image(image: AssetImage('assets/wm_green.png'))),
            SizedBox(
              width: double.infinity,
              height: 50,
            ),
            SizedBox(
                width: double.infinity,
                height: 200,
                child: Image(image: AssetImage('assets/dryer_red.png'))),
          ],
        ));
  }
}

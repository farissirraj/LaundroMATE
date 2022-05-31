// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);

  final _emailController = TextEditingController();
  final _phoneNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('S E T T I N G S'),
        backgroundColor: const Color.fromRGBO(0, 74, 173, 2),
      ),
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "NUS Email ID",
                  labelText: "Email",
                ),
              )),
          Padding(padding: EdgeInsets.all(0.5)),
          Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _phoneNoController,
                decoration: InputDecoration(
                  hintText: "Phone Number",
                  labelText: "Phone Number",
                ),
              )),
          Padding(padding: EdgeInsets.all(10)),
          SizedBox(
            width: 350.0,
            child: FloatingActionButton.extended(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      title: Text(''),
                      content: Text(
                        'S A V E D !',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                      actions: [
                        TextButton(
                          child: Text('OK'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ]),
                );
              },
              label: Text('S A V E'),
              icon: Icon(Icons.save),
              backgroundColor: Color.fromRGBO(0, 74, 173, 2),
            ),
          )
        ],
      ),
    );
  }
}

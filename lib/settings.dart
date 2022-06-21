// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:flutter/material.dart';

String name = '';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);

  final _nameController = TextEditingController();

  final _phoneNoController = TextEditingController();

  final _roomNoController = TextEditingController();

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
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Your Name",
                  labelText: "Name",
                ),
              )),
          Padding(padding: EdgeInsets.all(0.5)),
          SizedBox(
            width: 350.0,
            child: FloatingActionButton.extended(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      title: Text('Is this your email?'),
                      content: Text(
                        _nameController.text,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                      actions: [
                        TextButton(
                          child: Text('Yes'),
                          onPressed: () {
                            name = _nameController.text;
                            Navigator.pop(context);
                          },
                        ),
                      ]),
                );
              },
              label: Text('UPDATE EMAIL'),
              icon: Icon(Icons.save),
              backgroundColor: Color.fromRGBO(0, 74, 173, 2),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _phoneNoController,
                decoration: InputDecoration(
                  hintText: "Phone Number",
                  labelText: "Phone Number",
                ),
              )),
          Padding(padding: EdgeInsets.all(0.5)),
          SizedBox(
            width: 350.0,
            child: FloatingActionButton.extended(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      title: Text('Is this your Phone Number?'),
                      content: Text(
                        _phoneNoController.text,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                      actions: [
                        TextButton(
                          child: Text('Yes'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ]),
                );
              },
              label: Text('UPDATE PHONE NUMBER'),
              icon: Icon(Icons.save),
              backgroundColor: Color.fromRGBO(0, 74, 173, 2),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _roomNoController,
                decoration: InputDecoration(
                  hintText: "Room Number",
                  labelText: "Room Number",
                ),
              )),
          Padding(padding: EdgeInsets.all(0.5)),
          SizedBox(
            width: 350.0,
            child: FloatingActionButton.extended(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      title: Text('Is this your Room Number?'),
                      content: Text(
                        _roomNoController.text,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                      actions: [
                        TextButton(
                          child: Text('Yes'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ]),
                );
              },
              label: Text('UPDATE ROOM NUMBER'),
              icon: Icon(Icons.save),
              backgroundColor: Color.fromRGBO(0, 74, 173, 2),
            ),
          )
        ],
      ),
    );
  }
}

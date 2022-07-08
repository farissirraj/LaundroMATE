import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart' as globals;

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);

  final _nameController = TextEditingController();
  final _telegramController = TextEditingController();
  final fireStoreReference = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    void changeHandle(String newHandle) {
      globals.telegram = newHandle;
    }

    void resetPref(context) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('Onboarding', true);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('S E T T I N G S'),
        backgroundColor: const Color.fromRGBO(0, 74, 173, 2),
      ),
      body: Column(
        children: [
          // N A M E
          Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: globals.name,
                  labelText: "Name",
                ),
              )),
          const Padding(padding: EdgeInsets.all(0.5)),
          SizedBox(
            width: 350.0,
            child: FloatingActionButton.extended(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      title: const Text('Is this your email?'),
                      content: Text(
                        _nameController.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20),
                      ),
                      actions: [
                        TextButton(
                          child: const Text('Yes'),
                          onPressed: () {
                            globals.name = _nameController.text;
                            Navigator.pop(context);
                          },
                        ),
                      ]),
                );
              },
              label: const Text('UPDATE NAME'),
              icon: const Icon(Icons.save),
              backgroundColor: const Color.fromRGBO(0, 74, 173, 2),
            ),
          ),
          const Padding(padding: EdgeInsets.all(5)),

          // T E L E G R A M  H A N D L E
          Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _telegramController,
                decoration: InputDecoration(
                  hintText: globals.telegram,
                  labelText: "Telegram Handle",
                ),
              )),

          const Padding(padding: EdgeInsets.all(0.5)),

          SizedBox(
            width: 350.0,
            child: FloatingActionButton.extended(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      title: const Text('Is this your Telegram Handle?'),
                      content: Text(
                        _telegramController.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20),
                      ),
                      actions: [
                        TextButton(
                          child: const Text('Yes'),
                          onPressed: () {
                            fireStoreReference
                                .collection('RC4')
                                .doc(globals.telegram)
                                .delete();
                            changeHandle(_telegramController.text);
                            Navigator.of(context).pop();

                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    title: const Text('Alert!'),
                                    content: const Text(
                                        'Please rebook your appointment!'),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Okay!'))
                                    ],
                                  );
                                });
                          },
                        ),
                      ]),
                );
              },
              label: const Text('UPDATE TELEGRAM HANDLE'),
              icon: const Icon(Icons.save),
              backgroundColor: const Color.fromRGBO(0, 74, 173, 2),
            ),
          ),
          const Padding(padding: EdgeInsets.all(5)),
          const SizedBox(height: 250),

          //Delete Account
          SizedBox(
            width: 350.0,
            child: FloatingActionButton.extended(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      title: const Text('Do you want to Delete your Account?'),
                      content: const Text(
                        "All your appointment and data will be cleared!",
                        //textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                      actions: [
                        TextButton(
                          child: const Text('Yes'),
                          onPressed: () {
                            fireStoreReference
                                .collection('RC4')
                                .doc(globals.telegram)
                                .delete();
                            resetPref(context);
                            Navigator.pop(context);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    title: const Text('Alert!'),
                                    content: const Text('Deleted!'),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            exit(0);
                                          },
                                          child: const Text('Close'))
                                    ],
                                  );
                                });
                          },
                        ),
                        TextButton(
                          child: const Text('No'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ]),
                );
              },
              label: const Text('DELETE ACCOUNT'),
              icon: const Icon(Icons.delete),
              backgroundColor: const Color.fromARGB(253, 255, 0, 0),
            ),
          ),
        ],
      ),
    );
  }
}

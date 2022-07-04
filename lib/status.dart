import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart' as globals;

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
            const SizedBox(
              width: double.infinity,
              height: 50,
            ),
            SizedBox(
                width: double.infinity,
                height: 200,
                child: Image(image: AssetImage(globals.wmPath))),
            const SizedBox(
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

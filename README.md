# laundromate

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.




//*/
  /*ios
  await Firebase.initializeApp(
      options: FirebaseOptions(
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

  /* android
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: 'AIzaSyAUF5vVt8-X2oypuu_h5SWcE7WRs15Y1ig',
    appId: '1:596845297819:android:73649de62b31323d0a063e',
    messagingSenderId: '596845297819',
    projectId: 'laundromate-2e111',
    storageBucket: 'laundromate-2e111.appspot.com',
  ));
  */


  /*

  AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            iconSize: 20,
            onPressed: () {
              _goBack(context);
            },
          ),
          backgroundColor: const Color.fromRGBO(0, 74, 173, 2),
          title: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: const Text(
              'B O O K I N G',
              style: TextStyle(
                fontSize: 25,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
        ),
  leading: PopupMenuButton<String>(
              icon: const Icon(
                Icons.settings,
                color: Colors.black,
              ),
              itemBuilder: (BuildContext context) =>
                  options.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList(),
              onSelected: (String value) {
                if (value == 'Add') {
                  final now = DateTime.now().toUtc();
                  databaseReference
                      .collection("appointments")
                      .doc("appointments")
                      .collection('all')
                      .doc(
                          'month${now.month}day${now.day}:${now.hour}:${now.minute}:${now.second}')
                      .set({
                    'Subject': 'Mastering Flutter',
                    'StartTime': '10/06/2022 10:30',
                    'EndTime': '10/06/2022 10:00'
                  });
                } else if (value == "Delete") {
                  try {
                    databaseReference
                        .collection("appointments")
                        .doc('1')
                        .delete();
                  } catch (e) {}
                } else if (value == "Update") {
                  try {
                    databaseReference
                        .collection("appointments")
                        .doc('1')
                        .update({'Subject': 'Meeting'});
                  } catch (e) {}
                }
              },
            )

            */
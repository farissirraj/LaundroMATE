// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:laundromate/notificationservice.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'globals.dart' as globals;

_goBack(BuildContext context) {
  Navigator.pop(context);
}

void openTelegram() async {
  final url = Uri.parse(
    'https://tttttt.me/faris096',
  );
  if (await canLaunchUrl(url)) {
    launchUrl(url);
  } else {
    // ignore: avoid_print
    print("Can't launch $url");
  }
}

void checkStatus() async {
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
}

class BookingDetails extends StatelessWidget {
  const BookingDetails({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(0, 74, 173, 2),
        body: Center(
            child: Column(children: <Widget>[
          // ignore: avoid_unnecessary_containers
          Container(child: const Image(image: AssetImage('assets/logo.png'))),
          const SizedBox(width: 280.0, height: 50.0),
        ])));
  }
}

//Loads Appointments from Firestore db
class LoadDataFromFireBase extends StatelessWidget {
  const LoadDataFromFireBase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      //debugShowCheckedModeBanner: false,
      //title: 'FireBase',
      body: LoadDataFromFireStore(),
    );
  }
}

class LoadDataFromFireStore extends StatefulWidget {
  const LoadDataFromFireStore({Key? key}) : super(key: key);

  @override
  LoadDataFromFS createState() => LoadDataFromFS();
}

class LoadDataFromFS extends State<LoadDataFromFireStore> {
  final List<Color> _colorPalette = <Color>[];
  MeetingDataSource? events;
  final fireStoreReference = FirebaseFirestore.instance;
  bool isInitialLoaded = false;

  final CalendarController _controller = CalendarController();

  @override
  void initState() {
    _initializeEventColor();
    getDataFromFireStore().then((results) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });
    fireStoreReference.collection('RC4').snapshots().listen((event) {
      event.docChanges.forEach((element) {
        if (element.type == DocumentChangeType.added) {
          if (!isInitialLoaded) {
            return;
          }

          final Random random = Random();
          Meeting app =
              Meeting.fromFBSnap(element, _colorPalette[random.nextInt(9)]);
          setState(() {
            events!.appointments!.add(app);
            events!.notifyListeners(CalendarDataSourceAction.add, [app]);
          });
        } else if (element.type == DocumentChangeType.modified) {
          if (!isInitialLoaded) {
            return;
          }

          final Random random = Random();
          Meeting app =
              Meeting.fromFBSnap(element, _colorPalette[random.nextInt(9)]);
          setState(() {
            int index = events!.appointments!
                .indexWhere((app) => app.key == element.doc.id);
            Meeting meeting = events!.appointments![index];

            events!.appointments!.remove(meeting);
            events!.notifyListeners(CalendarDataSourceAction.remove, [meeting]);
            events!.appointments!.add(app);
            events!.notifyListeners(CalendarDataSourceAction.add, [app]);
          });
        } else if (element.type == DocumentChangeType.removed) {
          if (!isInitialLoaded) {
            return;
          }

          setState(() {
            int index = events!.appointments!
                .indexWhere((app) => app.key == element.doc.id);

            Meeting meeting = events!.appointments![index];

            events!.appointments!.remove(meeting);
            events!.notifyListeners(CalendarDataSourceAction.remove, [meeting]);
          });
        }
      });
    });
    super.initState();
  }

  Future<void> getDataFromFireStore() async {
    var snapShotsValue = await fireStoreReference.collection('RC4').get();

    final Random random = Random();
    List<Meeting> list = snapShotsValue.docs
        .map((e) => Meeting(
            eventName: e.data()['Subject'],
            from:
                DateFormat('dd/MM/yyyy HH:mm:ss').parse(e.data()['StartTime']),
            to: DateFormat('dd/MM/yyyy HH:mm:ss').parse(e.data()['EndTime']),
            background: _colorPalette[random.nextInt(9)],
            isAllDay: false,
            key: e.id))
        .toList();
    setState(() {
      events = MeetingDataSource(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    globals.temp = DateFormat('dd/MM/yyyy HH:mm:00').format(now);

    void selectionChanged(CalendarSelectionDetails details) async {
      if (_controller.view == CalendarView.month ||
          _controller.view == CalendarView.timelineMonth) {
        globals.temp = DateFormat('dd/MM/yyyy HH:mm:00').format(details.date!);
      } else {
        globals.temp = DateFormat('dd/MM/yyyy HH:mm:00').format(details.date!);
      }
      DateTime later = details.date!.add(const Duration(hours: 1));
      globals.select = later;
      globals.startTime = details.date!;
      globals.start = DateFormat('dd/MM/yyyy HH:mm:00').format(details.date!);
      globals.end = DateFormat('dd/MM/yyyy HH:mm:00').format(later);
      globals.endTime = later;
    }

    void delete(String telegram) {
      fireStoreReference.collection('RC4').doc(telegram).delete();
    }

    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              iconSize: 20.0,
              onPressed: () {
                _goBack(context);
              },
            ),
            title: const Text('B O O K I N G'),
            backgroundColor: const Color.fromRGBO(0, 74, 173, 2)),
        body: SfCalendar(
            key: const Key("CalendarUI"),
            view: CalendarView.week,
            dataSource: events,
            onSelectionChanged: selectionChanged,
            allowedViews: const [
              CalendarView.week,
              CalendarView.day,
              CalendarView.month,
            ],
            viewNavigationMode: ViewNavigationMode.snap,
            showDatePickerButton: true,
            showNavigationArrow: true,
            allowViewNavigation: true,
            headerStyle: const CalendarHeaderStyle(textAlign: TextAlign.center),
            viewHeaderStyle: const ViewHeaderStyle(
                backgroundColor: Color.fromARGB(253, 255, 255, 255)),
            controller: _controller,
            onTap: calendarTapped),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 500,
              ),

              //Delete Appointment Button
              FloatingActionButton(
                heroTag: null,
                key: const Key("DeleteButton"),
                backgroundColor: const Color.fromRGBO(0, 74, 173, 2),
                onPressed: () {
                  String? appointmentSlot = globals.appointment;

                  if (globals.appointment == '') {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              title: const Text('Alert!'),
                              content: const Text(
                                  'You do not have a laundry booking!'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    _goBack(context);
                                  },
                                )
                              ]);
                        });
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              title: const Text('Alert!'),
                              content: Text(
                                  'Are you sure you want to delete your laundry slot on $appointmentSlot'),
                              actions: <Widget>[
                                TextButton(
                                    child: const Text('Delete'),
                                    onPressed: () {
                                      globals.removePrefs(context);
                                      delete(globals.telegram);
                                      globals.appointment = '';
                                      _goBack(context);
                                      getDataFromFireStore();
                                    }),
                                TextButton(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    _goBack(context);
                                  },
                                )
                              ]);
                        });
                  }
                },
                child: const Icon(Icons.delete),
              ),
              const SizedBox(
                height: 10,
              ),

              //Refresh Calendar Button
              FloatingActionButton(
                heroTag: null,
                key: const Key("RefreshButton"),
                backgroundColor: const Color.fromRGBO(0, 74, 173, 2),
                onPressed: () {
                  getDataFromFireStore();
                },
                child: const Icon(Icons.refresh),
              ),
              const SizedBox(
                height: 10,
              ),

              //Add Appointment Button
              FloatingActionButton(
                  heroTag: null,
                  key: const Key("AddButton"),
                  backgroundColor: const Color.fromRGBO(0, 74, 173, 2),
                  onPressed: () {
                    globals.savePrefs();
                    fireStoreReference
                        .collection('RC4')
                        .doc(globals.telegram)
                        .set({
                      'Subject': globals.name,
                      'StartTime': globals.start,
                      'EndTime': globals.end
                    });
                    getDataFromFireStore();
                    globals.appointment = globals.start;
                    NotificationService().showNotification(1, "LaundroMATE",
                        "Your Laundry Appointment is approaching!");
                  },
                  child: const Icon(Icons.add)),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }

  //Appointment Tapped
  void calendarTapped(CalendarTapDetails details) async {
    //String tele = globals.telegram;
    if (details.targetElement == CalendarElement.appointment ||
        details.targetElement == CalendarElement.agenda) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: const Text('Options:'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    openTelegram();
                    _goBack(context);
                  },
                  child: const Text('Message'),
                ),
                TextButton(
                  onPressed: () {
                    checkStatus();
                    NotificationService().cancelNotifications();
                    _goBack(context);
                    getDataFromFireStore();
                  },
                  child: const Text('Started/Finished'),
                ),
                TextButton(
                  onPressed: () => _goBack(context),
                  child: const Text('Cancel'),
                ),
              ],
            );
          });
    }
  }

  void _initializeEventColor() {
    _colorPalette.add(const Color.fromARGB(255, 31, 99, 62));
    _colorPalette.add(const Color.fromARGB(255, 190, 94, 216));
    _colorPalette.add(const Color.fromARGB(255, 154, 33, 33));
    _colorPalette.add(const Color.fromARGB(255, 221, 135, 103));
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  String? eventName;
  DateTime? from;
  DateTime? to;
  Color? background;
  bool? isAllDay;
  String? key;

  Meeting(
      {this.eventName,
      this.from,
      this.to,
      this.background,
      this.isAllDay,
      this.key});

  static Meeting fromFBSnap(dynamic element, Color color) {
    return Meeting(
        eventName: element.doc.data()!['Subject'],
        from: DateFormat('dd/MM/yyyy HH:mm:ss')
            .parse(element.doc.data()!['StartTime']),
        to: DateFormat('dd/MM/yyyy HH:mm:ss')
            .parse(element.doc.data()!['EndTime']),
        background: color,
        isAllDay: false,
        key: element.doc.id);
  }
}

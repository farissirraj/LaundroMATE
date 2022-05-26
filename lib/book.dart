// ignore_for_file: empty_catches

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class LoadDataFromFireBase extends StatelessWidget {
  const LoadDataFromFireBase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FireBase',
      home: LoadDataFromFireStore(),
    );
  }
}

class LoadDataFromFireStore extends StatefulWidget {
  const LoadDataFromFireStore({Key? key}) : super(key: key);

  @override
  LoadDataFromFireStoreState createState() => LoadDataFromFireStoreState();
}

class LoadDataFromFireStoreState extends State<LoadDataFromFireStore> {
  final List<Color> _colorCollection = <Color>[];
  MeetingDataSource? events;
  MeetingDataSource? events1;
  final List<String> options = <String>['Add', 'Delete', 'Update'];
  final databaseReference = FirebaseFirestore.instance;

  @override
  void initState() {
    _initializeEventColor();
    getDataFromFireStore().then((results) {
      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });
    super.initState();
  }

  Future<void> getDataFromFireStore() async {
    final now = DateTime.now().toUtc();
    var snapShotsValue = await databaseReference
        .collection("appointments")
        .doc("appointments")
        .collection('all')
        .get();

    final Random random = Random();
    List<Meeting> list = snapShotsValue.docs
        .map((e) => Meeting(
            eventName: e.data()['description'],
            from: DateFormat('dd/MM/yyyy HH:mm:ss').parse(e.data()['date']),
            to: DateFormat('dd/MM/yyyy HH:mm:ss').parse(e.data()['date']),
            background: _colorCollection[random.nextInt(9)],
            isAllDay: false))
        .toList();

    setState(() {
      events = MeetingDataSource(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
            )),
        body: SfCalendar(
          view: CalendarView.month,
          onTap: calendarTapped,
          allowedViews: const [
            CalendarView.week,
            CalendarView.schedule,
            CalendarView.month,
          ],
          timeSlotViewSettings: const TimeSlotViewSettings(
              startHour: 9,
              endHour: 21,
              nonWorkingDays: <int>[DateTime.friday, DateTime.monday]),
          initialDisplayDate: DateTime.now(),
          dataSource: events,
          monthViewSettings: const MonthViewSettings(
            showAgenda: true,
          ),
        ));
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {}

  void _initializeEventColor() {
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF36B37B));
    _colorCollection.add(const Color(0xFF01A1EF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));
    _colorCollection.add(const Color(0xFF0A8043));
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }
}

class Meeting {
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;

  Meeting(
      {required this.eventName,
      required this.from,
      required this.to,
      required this.background,
      required this.isAllDay});
}

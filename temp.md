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
  /*
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FireBase',
      home: LoadDataFromFireStore(),
    );
  }
  */

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoadDataFromFireStore(),
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
  //MeetingDataSource? events1;
  //final List<String> options = <String>['Add', 'Delete', 'Update'];
  final databaseReference = FirebaseFirestore.instance;

  final CalendarController _controller = CalendarController();

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
    //final now = DateTime.now().toUtc();
    var snapShotsValue = await databaseReference
        .collection("CalendarAppointmentCollection")
        .get();

    final Random random = new Random();
    List<Meeting> list = snapShotsValue.docs
        .map((e) => Meeting(
              eventName: e.data()['Subject'],
              from: DateFormat('dd/MM/yyyy HH:mm:ss')
                  .parse(e.data()['StartTime']),
              to: DateFormat('dd/MM/yyyy HH:mm:ss').parse(e.data()['EndTime']),
              background:
                  _colorCollection[random.nextInt(9)], /*isAllDay: false*/
            ))
        .toList();
    setState(() {
      events = MeetingDataSource(list);
    });
  }

  _goBack(BuildContext context) {
    Navigator.pop(context, true);
  }

  void add() {}

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: const Color.fromRGBO(0, 74, 173, 2),
      ),
      body: SfCalendar(
        view: CalendarView.month,
        dataSource: events,
        monthViewSettings: const MonthViewSettings(
            showAgenda: true,
            navigationDirection: MonthNavigationDirection.vertical),
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
        initialDisplayDate: DateTime.now(),
        onTap: calendarTapped,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(0, 74, 173, 2),
        onPressed: () {
          databaseReference
              .collection("CalendarAppointmentCollection")
              .doc("3")
              .set({
            'Subject': 'Mastering Flutter',
            'StartTime': '30/05/2022 08:00:00',
            'EndTime': '30/05/2022 10:00:00'
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (_controller.view == CalendarView.month &&
        calendarTapDetails.targetElement == CalendarElement.calendarCell) {
      _controller.view = CalendarView.day;
    } else if ((_controller.view == CalendarView.week ||
            _controller.view == CalendarView.workWeek) &&
        calendarTapDetails.targetElement == CalendarElement.viewHeader) {
      _controller.view = CalendarView.day;
    }
  }

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
  /*bool isAllDay;*/

  Meeting({
    required this.eventName,
    required this.from,
    required this.to,
    required this.background,
    /*required this.isAllDay*/
  });
}









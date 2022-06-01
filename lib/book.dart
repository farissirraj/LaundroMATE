// ignore_for_file: avoid_function_literals_in_foreach_calls, prefer_adjacent_string_concatenation, unnecessary_string_interpolations

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';
import 'settings.dart';

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
  LoadDataFromFireStoreState createState() => LoadDataFromFireStoreState();
}

class LoadDataFromFireStoreState extends State<LoadDataFromFireStore> {
  //final List<TimeRegion>? _specialTimeRegions = <TimeRegion>[];
  final List<Color> _colorCollection = <Color>[];
  MeetingDataSource? events;
  //final List<String> options = <String>['Add', 'Delete', 'Update'];
  final fireStoreReference = FirebaseFirestore.instance;
  bool isInitialLoaded = false;

  final CalendarController _controller = CalendarController();

  @override
  void initState() {
    _initializeEventColor();
    getDataFromFireStore().then((results) {
      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });
    fireStoreReference
        .collection("CalendarAppointmentCollection")
        .snapshots()
        .listen((event) {
      event.docChanges.forEach((element) {
        if (element.type == DocumentChangeType.added) {
          if (!isInitialLoaded) {
            return;
          }

          final Random random = Random();
          Meeting app = Meeting.fromFireBaseSnapShotData(
              element, _colorCollection[random.nextInt(9)]);
          setState(() {
            events!.appointments!.add(app);
            events!.notifyListeners(CalendarDataSourceAction.add, [app]);
          });
        } else if (element.type == DocumentChangeType.modified) {
          if (!isInitialLoaded) {
            return;
          }

          final Random random = Random();
          Meeting app = Meeting.fromFireBaseSnapShotData(
              element, _colorCollection[random.nextInt(9)]);
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
    var snapShotsValue = await fireStoreReference
        .collection("CalendarAppointmentCollection")
        .get();

    final Random random = Random();
    List<Meeting> list = snapShotsValue.docs
        .map((e) => Meeting(
            eventName: e.data()['Subject'],
            from:
                DateFormat('dd/MM/yyyy HH:mm:ss').parse(e.data()['StartTime']),
            to: DateFormat('dd/MM/yyyy HH:mm:ss').parse(e.data()['EndTime']),
            background: _colorCollection[random.nextInt(9)],
            isAllDay: false,
            key: e.id))
        .toList();
    setState(() {
      events = MeetingDataSource(list);
    });
  }

  _goBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    //isInitialLoaded = true;
    String _text = '';
    // String _time =
    //     DateTime.parse(_text).add(const Duration(hours: 1)).toString();

    void selectionChanged(CalendarSelectionDetails details) {
      //DateTime dt;
      if (_controller.view == CalendarView.month ||
          _controller.view == CalendarView.timelineMonth) {
        _text = DateFormat('dd/MM/yyyy').format(details.date!).toString();
      } else {
        _text =
            DateFormat('dd/MM/yyyy HH:mm:ss').format(details.date!).toString();
      }
    }

    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              iconSize: 20.0,
              onPressed: () {
                //Navigator.pop(context, true);
                _goBack(context);
              },
            ),
            title: const Text('B O O K I N G'),
            backgroundColor: const Color.fromRGBO(0, 74, 173, 2)),

        //Calendar UI
        body: SfCalendar(
          view: CalendarView.week,
          dataSource: events,
          onSelectionChanged: selectionChanged,
          controller: _controller,
          onTap: calendarTapped,
          dragAndDropSettings: const DragAndDropSettings(
            indicatorTimeFormat: 'hh:mm',
            showTimeIndicator: true,
            timeIndicatorStyle: TextStyle(
              backgroundColor: Color(0xFFCEE5D0),
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          viewNavigationMode: ViewNavigationMode.snap,
          showDatePickerButton: true,
          showNavigationArrow: true,
          headerStyle: const CalendarHeaderStyle(textAlign: TextAlign.center),
          viewHeaderStyle: const ViewHeaderStyle(
              backgroundColor: Color.fromARGB(253, 255, 255, 255)),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 500,
              ),

              //Refresh Button
              FloatingActionButton(
                backgroundColor: const Color.fromRGBO(0, 74, 173, 2),
                onPressed: () {
                  getDataFromFireStore();
                },
                child: const Icon(Icons.refresh),
              ),

              const SizedBox(
                height: 10,
              ),

              //Set Appt Button +
              FloatingActionButton(
                backgroundColor: const Color.fromRGBO(0, 74, 173, 2),
                onPressed: () {
                  fireStoreReference
                      .collection("CalendarAppointmentCollection")
                      .doc("1")
                      .set({
                    'Subject': 'Name',
                    'StartTime': _text,
                    'EndTime': DateFormat('dd/MM/yyyy HH:mm:ss')
                        .parse(_text)
                        .add(const Duration(hours: 1))
                        .toString()
                  });
                },
                child: const Icon(Icons.add),
              ),

              const SizedBox(
                height: 10,
              ),

              //Delete Appt Button -
              FloatingActionButton(
                backgroundColor: const Color.fromRGBO(0, 74, 173, 2),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                              "Details shown by selection changed callback"),
                          content: Text("You have selected " + '$_text'),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('close'))
                          ],
                        );
                      });
                },
                child: const Icon(Icons.delete),
              )
            ],
          ),
        ));
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

  static Meeting fromFireBaseSnapShotData(dynamic element, Color color) {
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

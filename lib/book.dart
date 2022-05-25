import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'dart:math';
import 'package:http/http.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

/*
class Book extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables3
  const Book({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: dead_code
    return Scaffold(
      appBar: AppBar(
        title: const Text('B O O K I N G S'),
        backgroundColor: const Color.fromRGBO(0, 74, 173, 2),
      ),
      body: Center(
        child: SfCalendar(
          view: CalendarView.month,
          initialSelectedDate: DateTime.now(),
        ),
      ),
    );
  }
}
*/

class GoogleSheetData extends StatefulWidget {
  const GoogleSheetData({Key? key}) : super(key: key);

  @override
  LoadDataFromGoogleSheetState createState() => LoadDataFromGoogleSheetState();
}

class LoadDataFromGoogleSheetState extends State<GoogleSheetData> {
  MeetingDataSource? events;
  final List<Color> _colorCollection = <Color>[];
  final CalendarController _controller = CalendarController();

  void calendarTapped(CalendarTapDetails calendarTapDetails) { if (_controller.view == CalendarView.month && calendarTapDetails.targetElement == CalendarElement.calendarCell) {_controller.view = CalendarView.day; } else if ((_controller.view == CalendarView.week || _controller.view == CalendarView.workWeek) && calendarTapDetails.targetElement == CalendarElement.viewHeader) { _controller.view = CalendarView.day; }}

  @override
  void initState() {
    _initializeEventColor();
    super.initState();
  }

  _goBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              iconSize: 20.0,
              onPressed: () {
                _goBack(context);
              },
            ),
            title: const Text('B O O K I N G S'),
            backgroundColor: const Color.fromRGBO(0, 74, 173, 2),
          ),
          body: SafeArea(
              // ignore: avoid_unnecessary_containers
              child: Container(
            child: FutureBuilder(
              future: getDataFromGoogleSheet(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data != null) {
                  return SafeArea(
                      // ignore: avoid_unnecessary_containers
                      child: Container(
                    child:  SfCalendar(
                       view: CalendarView.month,
                        allowedViews: const [
                           CalendarView.day,
                           CalendarView.week,
                           CalendarView.month,
                           ],
                           viewHeaderStyle:
                           const ViewHeaderStyle(backgroundColor:  Colors.white,),
                           backgroundColor:  Colors.white,
                           controller: _controller,
                           initialDisplayDate: snapshot.data[0].from,
                           dataSource: MeetingDataSource(snapshot.data),
                           onTap: calendarTapped,
                           monthViewSettings: const MonthViewSettings(
                             navigationDirection: MonthNavigationDirection.vertical),
                             ),
                    ),
                  ); }else {
                  // ignore: avoid_unnecessary_containers
                  return Container(
                    child: const Center(
                      child: Text('Loading.....'),
                    ),
                  );
                }
              },
            )
              )
          )
      )
    );
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

  Future<List<Meeting>> getDataFromGoogleSheet() async {
    Response data = await http.get(
      Uri.parse(
          "https://script.google.com/macros/s/AKfycbwG-W8x3ojt3-h5F-2IsmfdfTTdGo-bJiYF9gtBfC80KWNc7Qfv3DlApShRwYanHZia4A/exec"),
    );
    dynamic jsonAppData = convert.jsonDecode(data.body);
    final List<Meeting> appointmentData = [];
    final Random random = Random();
    for (dynamic data in jsonAppData) {
      Meeting meetingData = Meeting(
        eventName: data['subject'],
        from: _convertDateFromString(data['starttime']),
        to: _convertDateFromString(data['endtime']),
        background: _colorCollection[random.nextInt(9)],
      );
      appointmentData.add(meetingData);
    }
    return appointmentData;
  }

  DateTime _convertDateFromString(String date) {
    return DateTime.parse(date);
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
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }
}

class Meeting {
  Meeting(
      {this.eventName = '',
      required this.from,
      required this.to,
      this.background,
      this.isAllDay = false});

  String? eventName;
  DateTime? from;
  DateTime? to;
  Color? background;
  bool? isAllDay;
}

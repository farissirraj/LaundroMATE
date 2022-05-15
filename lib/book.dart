import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Book extends StatelessWidget {
  //const Book({Key? key}) : super(key: key);

  List<String> items = <String>['1', '2'];
  String? electedItem = '1';

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

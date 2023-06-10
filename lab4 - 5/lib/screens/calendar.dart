import 'package:flutter/material.dart';
import 'package:lab4/model/exam_item.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatelessWidget {
  static const routeName = '/calendar';

  @override
  Widget build(BuildContext context) {
    final items = ModalRoute.of(context)
    !.settings.arguments as List<ExamItem>;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: SfCalendar(
        view: CalendarView.month,
        //view: CalendarView.week,
        dataSource: MeetingDataSource(getAppointments(items)),

      ),
    );
  }
}

List<Appointment> getAppointments(List<ExamItem> items){
  List<Appointment> meetings = <Appointment>[];
  for (var element in items) {
    meetings.add(Appointment(
      startTime: element.datum,
      endTime: element.datum.add(const Duration(hours: 2)),
      subject: element.naslov,
      color: Colors.blue,
    ));
  }
  return meetings;
}

class MeetingDataSource extends CalendarDataSource{
  MeetingDataSource(List<Appointment> source){
    appointments = source;
  }
}
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Appointment',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
            selectedDayPredicate: (day) {
              // Return true if the day is the selected date, false otherwise
              return isSameDay(_selectedDate, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
              });
            },
          ),
          const SizedBox(height: 50),
          if (_selectedDate != null)
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey[200],
              child: Text(
                'Appointment Date: ${_selectedDate!.toString()}',
                style: TextStyle(fontSize: 18),
              ),
            ),
        ],
      ),
    );
  }
}



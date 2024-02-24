import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final kFirstDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month - 3,
    DateTime.now().day,
  );
  final kLastDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month + 3,
    DateTime.now().day,
  );

  String get year => '${(_focusedDay.year)}';

  @override
  Widget build(BuildContext context) {
    final double buttonWidth = MediaQuery.of(context).size.width * 0.8;
    final double buttonHeight = 60.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Activity'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              locale: 'en_EN',
              firstDay: kFirstDay,
              lastDay: kLastDay,
              headerStyle: HeaderStyle(
                titleTextStyle: TextStyle(fontSize: 18),
                titleTextFormatter: (date, locale) =>
                    '${DateFormat.MMMMEEEEd(locale).format(date)} $year',
              ),
              calendarStyle: const CalendarStyle(
                isTodayHighlighted: false,
                selectedDecoration:
                    BoxDecoration(color: Colors.purple, shape: BoxShape.circle),
              ),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              availableCalendarFormats: {CalendarFormat.month: "month"},
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
              },
            ),
            SizedBox(height: 20), // Adds space above the first button
            SizedBox(
              width: buttonWidth,
              height: buttonHeight,
              child: ElevatedButton.icon(
                icon: Icon(Icons.list),
                label: Text('Your activity'),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/ActivityList');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: buttonWidth,
              height: buttonHeight,
              child: ElevatedButton.icon(
                icon: Icon(Icons.add),
                label: Text('Add new activity'),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/ActivityAdd');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: BottomNavigationBar(
          selectedItemColor: Colors.grey,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Activity',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: 'Weather',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.pushReplacementNamed(context, '/Home');
                break;
              case 1:
                Navigator.pushReplacementNamed(context, '/Activity');
                break;
              case 2:
                Navigator.pushReplacementNamed(context, '/Weather');
                break;
              case 3:
                Navigator.pushReplacementNamed(context, '/UserSetting');
                break;
            }
          },
        ),
      ),
    );
  }
}

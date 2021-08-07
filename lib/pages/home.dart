import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/workout.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<DateTime, List<Workout>> selectedEvents = {};
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  List<Workout> _getWorkoutsFromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Workout"),
          centerTitle: true,
        ),
        body: Column(children: [
          TableCalendar(
            focusedDay: selectedDay,
            firstDay: DateTime(1990),
            lastDay: DateTime(2050),
            calendarFormat: format,
            onFormatChanged: (CalendarFormat _format) {
              setState(() {
                format = _format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.monday,
            daysOfWeekVisible: true,

            //Day changed
            onDaySelected: (DateTime selectDay, DateTime focusDay) {
              setState(() {
                selectedDay = selectDay;
                focusedDay = focusDay;
              });
              // print(focusedDay);
            },
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDay, date);
            },

            eventLoader: _getWorkoutsFromDay,
            // Style the calendar
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                color: Colors.purpleAccent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              weekendDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
              formatButtonShowsNext: false,
              formatButtonDecoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5.0),
              ),
              formatButtonTextStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ..._getWorkoutsFromDay(selectedDay).map((Workout workout) => ListTile(
              leading: Icon(Icons.fitness_center),
              title: Text(workout.name),
              onTap: () =>
                  Navigator.pushNamed(context, '/workout', arguments: 0)))
        ]),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text("Add Workout"),
                      content: TextFormField(controller: _eventController),
                      actions: [
                        TextButton(
                          child: Text("Cancel"),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: Text("Ok"),
                          onPressed: () {
                            if (selectedEvents[selectedDay] != null) {
                              selectedEvents[selectedDay]!
                                  .add(Workout("test", <Exercice>[]));
                            } else {
                              selectedEvents[selectedDay] = [
                                Workout("test", <Exercice>[])
                              ];
                            }
                            setState(() {});
                          },
                        ),
                      ],
                    )),
            label: Text("Add Event"),
            icon: Icon(Icons.add)));
  }
}

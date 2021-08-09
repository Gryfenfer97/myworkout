import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/workout.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Workout todayWorkout = Workout("Full Body", <Exercice>[
    Exercice("Squats", <Serie>[
      Serie(12, 67.5, Duration(seconds: 90)),
      Serie(12, 67.5, Duration(seconds: 90)),
      Serie(12, 67.5, Duration(seconds: 90)),
      Serie(12, 67.5, Duration(seconds: 90)),
    ]),
    Exercice("Développé couché", <Serie>[
      Serie(12, 52.5, Duration(seconds: 90)),
      Serie(12, 52.5, Duration(seconds: 90)),
      Serie(12, 52.5, Duration(seconds: 90)),
      Serie(12, 52.5, Duration(seconds: 90)),
    ]),
    Exercice("Rowing", <Serie>[
      Serie(10, 32.5, Duration(seconds: 90)),
      Serie(10, 32.5, Duration(seconds: 90)),
      Serie(10, 32.5, Duration(seconds: 90)),
      Serie(10, 32.5, Duration(seconds: 90)),
    ]),
    Exercice("Élévations latérales", <Serie>[
      Serie(15, 8, Duration(seconds: 60)),
      Serie(15, 8, Duration(seconds: 60)),
      Serie(15, 8, Duration(seconds: 60)),
    ]),
    Exercice("Curl barre", <Serie>[
      Serie(12, 20, Duration(seconds: 60)),
      Serie(12, 20, Duration(seconds: 60)),
      Serie(12, 20, Duration(seconds: 60)),
    ]),
    Exercice("Extension triceps", <Serie>[
      Serie(12, 23.5, Duration(seconds: 60)),
      Serie(12, 23.5, Duration(seconds: 60)),
      Serie(12, 23.5, Duration(seconds: 60)),
    ]),
  ]);
  final Workout todayWorkout2 = Workout("Pecs2", <Exercice>[
    Exercice("Développé couché", <Serie>[
      Serie(12, 52.5, Duration(seconds: 90)),
      Serie(12, 52.5, Duration(seconds: 90)),
      Serie(12, 52.5, Duration(seconds: 90)),
      Serie(12, 52.5, Duration(seconds: 90)),
    ]),
    Exercice("Rowing", <Serie>[
      Serie(10, 32.5, Duration(seconds: 90)),
      Serie(10, 32.5, Duration(seconds: 90)),
      Serie(10, 32.5, Duration(seconds: 90)),
      Serie(10, 32.5, Duration(seconds: 90)),
    ]),
  ]);

  var _selectedValue;
  Map<DateTime, List<Workout>> selectedEvents = {};
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  final WorkoutStorage storage = WorkoutStorage();

  var _workoutList = <DropdownMenuItem<Workout>>[];

  TextEditingController _eventController = TextEditingController();

  _loadWorkoutList() {
    var workoutList = [todayWorkout, todayWorkout2];
    workoutList.forEach((element) {
      setState(() {
        _workoutList
            .add(DropdownMenuItem(child: Text(element.name), value: element));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // _selectedValue = "";
    _loadWorkoutList();
    selectedEvents = {
      DateTime.now(): <Workout>[todayWorkout],
    };
    // storage.writeFile("GigaTest");
    storage.readFile().then((e) => print("storage content: $e"));
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
                  Navigator.pushNamed(context, '/workout', arguments: workout)))
        ]),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: Text("Ajouter un entrainement"),
                      // content: TextFormField(controller: _eventController),
                      content: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return DropdownButtonFormField<Workout>(
                              hint: Text("Choisir un entrainement"),
                              value: _selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  _selectedValue = value;
                                });
                              },
                              onSaved: (value) {
                                setState(() {
                                  _selectedValue = value;
                                });
                              },
                              items: _workoutList);
                        },
                      ),
                      actions: [
                        TextButton(
                          child: Text("Cancel"),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: Text("Ok"),
                          onPressed: () {
                            if (selectedEvents[selectedDay] != null) {
                              selectedEvents[selectedDay]!.add(_selectedValue);
                            } else {
                              selectedEvents[selectedDay] = [_selectedValue];
                            }
                            setState(() {});
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    )),
            label: Text("Add Event"),
            icon: Icon(Icons.add)));
  }
}

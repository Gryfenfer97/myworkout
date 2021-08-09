import 'package:flutter/material.dart';
import 'package:myworkout/models/workout.dart';

class ExercicePage extends StatefulWidget {
  @override
  _ExercicePageState createState() => _ExercicePageState();
}

class _ExercicePageState extends State<ExercicePage> {
  format(Duration d) => d.toString().substring(2, 7);

  @override
  Widget build(BuildContext context) {
    final exercice = ModalRoute.of(context)!.settings.arguments as Exercice;
    return Scaffold(
      appBar: AppBar(
          title: Text("My Workout"),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context))),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(exercice.name),
              height: 50,
            ),
            ...exercice.series.map((Serie serie) => Row(
                  children: [
                    Expanded(
                        child: Center(
                            child: Text(
                      "${serie.nbReps} reps",
                      style: TextStyle(fontSize: 25),
                    ))),
                    Expanded(
                        child: Center(
                            child: Text("${serie.weight} kg",
                                style: TextStyle(fontSize: 25)))),
                    Expanded(
                        child: Center(
                            child: Text("${format(serie.restTime)}",
                                style: TextStyle(fontSize: 25))))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

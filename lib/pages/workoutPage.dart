import 'package:flutter/material.dart';
import '../models/workout.dart';

class WorkoutPage extends StatelessWidget {
  final Workout workout = Workout("Full Body", <Exercice>[
    Exercice("Développé couché", <Serie>[
      Serie(12, 52.5, Duration(seconds: 90)),
      Serie(12, 52.5, Duration(seconds: 90))
    ]),
    Exercice("Squats", <Serie>[
      Serie(12, 67.5, Duration(seconds: 90)),
      Serie(12, 67.5, Duration(seconds: 90)),
    ])
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Column(children: [
        ...workout.exercices.map((Exercice exercice) => ListTile(
              title: Text(exercice.name),
              subtitle: Text(
                  "${exercice.series.length} ${exercice.series.length == 1 ? "série" : "séries"}"),
            )),
      ])),
    );
  }
}

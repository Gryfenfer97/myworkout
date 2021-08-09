import 'package:flutter/material.dart';
import '../models/workout.dart';

class WorkoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final workout = ModalRoute.of(context)!.settings.arguments as Workout;
    return Scaffold(
      appBar: AppBar(
        title: Text("My Workout"),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        ...workout.exercices.map((Exercice exercice) => ListTile(
              title: Text(exercice.name),
              subtitle: Text(
                  "${exercice.series.length} ${exercice.series.length == 1 ? "série" : "séries"}"),
              onTap: () => Navigator.pushNamed(context, '/exercice',
                  arguments: exercice),
            )),
      ])),
    );
  }
}

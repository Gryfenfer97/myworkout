import 'package:flutter/material.dart';

class Serie {
  int nbReps;
  int weight; // kg
  Duration sleepTime;

  Serie({
    this.nbReps = 0,
    this.weight = 0,
    Duration? sleepTime,
  }) : this.sleepTime = sleepTime ?? Duration(seconds: 0);
}

class Exo {
  int id;
  String name;
  int nbSeries;
  List<Serie> series;

  Exo(
      {required this.id,
      this.name = "undefined",
      this.nbSeries = 0,
      required this.series});
}

class ExercicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as int;
    Exo exo = new Exo(id: args, name: "Développé couché", nbSeries: 4, series: [
      Serie(
          nbReps: 123,
          weight: 55,
          sleepTime: Duration(minutes: 1, seconds: 30)),
      Serie(
          nbReps: 12, weight: 55, sleepTime: Duration(minutes: 1, seconds: 30))
    ]);
    return Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text("${exo.name}"),
      SeriesWidget(series: exo.series),
      Text("Commentary section"),
      CommentarySection(),
    ]));
  }
}

class SeriesWidget extends StatelessWidget {
  final List<Serie> series;
  SeriesWidget({Key? key, required this.series});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            for (var serie in series)
              Container(
                  color: Colors.grey,
                  height: 40,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        "${serie.nbReps} reps",
                        textAlign: TextAlign.center,
                      )),
                      Expanded(
                          child: Text(
                        "${serie.weight} kg",
                        textAlign: TextAlign.center,
                      )),
                      Expanded(
                          child: Text(
                        "${serie.sleepTime.toString().substring(2, 7)}",
                        textAlign: TextAlign.center,
                      )),
                    ],
                  ))
          ],
        ));
  }
}

class CommentarySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
      ),
      padding: EdgeInsets.all(20),
    );
  }
}

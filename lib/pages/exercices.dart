import 'package:flutter/material.dart';

class Exercices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Exercice(name: "Developpé couché", id: 0),
        Exercice(name: "Squats", id: 1),
        Exercice(name: "Rowing", id: 2),
        Exercice(name: "Élévation latérales", id: 3),
        Exercice(name: "Curl barre", id: 4),
        Exercice(name: "Extension triceps", id: 5),
      ],
    ));
  }
}

class Exercice extends StatelessWidget {
  final String name;
  final int id;
  Exercice({Key? key, required this.name, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        height: 100,
        child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/exo', arguments: this.id);
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  children: [
                    Container(width: 50),
                    Expanded(child: Text("$name"))
                  ],
                ))));
  }
}

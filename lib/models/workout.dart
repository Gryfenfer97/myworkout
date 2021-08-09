import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Serie {
  final int nbReps;
  final double weight; // kg
  final Duration restTime;

  Serie(this.nbReps, this.weight, this.restTime);
}

class Exercice {
  final String name;
  final List<Serie> series;

  Exercice(this.name, this.series);
}

class Workout {
  final String name;
  final List<Exercice> exercices;

  Workout(this.name, this.exercices);
}

class WorkoutStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print(path);
    return File('$path/workouts.txt');
  }

  Future<String> readFile() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return "";
    }
  }

  Future<File> writeFile(String name) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$name');
  }

  void test() async {
    final file = await _localFile;
    print(file.path);
  }
}

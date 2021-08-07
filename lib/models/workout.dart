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

import 'package:flutter/material.dart';
import 'package:myworkout/pages/exercicesPage.dart';
import 'pages/home.dart';
import 'pages/workoutPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My Workout',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/workout': (context) => WorkoutPage(),
          '/exo': (context) => ExercicesPage(),
        });
  }
}

// class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
//   Size get preferredSize => new Size.fromHeight(50);
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//           onPressed: () => Navigator.pop(context)),
//       title: Text("My Workout"),
//       backgroundColor: Colors.blue,
//       centerTitle: true,
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

  // final firestoreInstance = FirebaseFirestore.instance;

  // @override
  // Widget build(BuildContext context) {
  //   // CollectionReference workouts = FirebaseFirestore.instance.collection('workouts');
  //   return Scaffold(
  //     appBar: MyAppBar(),
  //     body: Center(
  //       child: HomePage(),
  //     ),
  //     floatingActionButton: FloatingActionButton.extended(
  //         onPressed: () => showDialog(
  //             context: context,
  //             builder: (context) => AlertDialog(title: Text("Add Event"))),
  //         label: Text("Add Event"),
  //         icon: Icon(Icons.add)),
  //   );
  // }
// }

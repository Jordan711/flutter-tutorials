import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:math';

// use icon.kitchen to generate icons for project

// Cold boot - emulator starts up completely from dead
// Quick boot - emulator starts up from last state just before it was closed

// Hot reload - Only the code in the build method gets reloaded
// only the code that affects the UI (like in the build() method or any widget updates) is re-run.

// late - declare a non-nullable variable that will be initialized later
// const - values assigned to a const variable are fixed at the time of compilation and can never be altered
// - Value must be known at compile-time
// final - can't be reassigned, but the object can be mutated
// - Value must be known at compile-time

// Maps are collection of key value pairs

// Null safety  - avoid null errors, using a variable that doesn't have a value
// Variables can't hold null unless you say they can
// int? b; --> Nullable integer, can hold either integer value or null
// name?.length --> access length attribute if name is not null
// name ?? 'Guest' --> Provide a default value if name is null

void main() {
  Map<String, String> test = {'name': 'poop', 'hahah': 'lol'};
  test['fffff'] = 'ddsafsa';
  test.forEach((key, value) => print('$key:$value'));

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Random random = new Random();
  List<Color> colours = [
    Colors.white,
    Colors.teal,
    Colors.black,
    Colors.pinkAccent,
    Colors.red,
    Colors.purple
  ];
  List sounds = [
    'Kick.wav',
    'Ride.wav',
    'Snare.wav',
    'Tom.wav'
  ];
  int appBar = 0;
  int scaffold = 0;
  int soundPosition = 0;

  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: colours[appBar],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: colours[scaffold],
          title: IconButton(onPressed: () {
            soundPosition = random.nextInt(sounds.length);
          }, icon: Icon(Icons.refresh, color: Colors.green,))
        ),
        body: ListView(
          // This widget will use the max width and height of the parent
          // SingleChildScrollView
          // Wrap widget moves items to a new line if not enough space in the current row
          // Stack widget places items on top of each other, last child is always on top
          // alignment: Alignment.<>
          // Stack > Positioned > Container
          scrollDirection: Axis.vertical,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment
                  .center, // .values[i] where i is index of end, center, stretch
              children: [
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      appBar = random.nextInt(colours.length );
                      scaffold = random.nextInt(colours.length );
                      player.play(AssetSource(sounds[soundPosition]));
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        color: Colors.yellow,
                        child: Center(
                          child: Image.asset('images/dashatar.png'),
                        ),
                      ),
                      Text('Click me'),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.yellow,
                  child: Center(child: Image.asset('images/dashatar.png')),
                ),
                Container(
                  height: 100,
                  width: 300,
                  color: Colors.teal,
                  child: Center(child: Image.asset('images/dashatar.png')),
                ),
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.brown,
                  child: Center(child: Image.asset('images/dashatar.png')),
                ),
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.red,
                  child: Center(child: Image.asset('images/dashatar.png')),
                ),
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.deepPurple,
                  child: Center(child: Image.asset('images/dashatar.png')),
                ),
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.yellow,
                  child: Center(child: Image.asset('images/dashatar.png')),
                ),
                Container(
                  height: 100,
                  width: 300,
                  color: Colors.teal,
                  child: Center(child: Image.asset('images/dashatar.png')),
                ),
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.brown,
                  child: Center(child: Image.asset('images/dashatar.png')),
                ),
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.red,
                  child: Center(child: Image.asset('images/dashatar.png')),
                ),
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.yellow,
                  child: Center(child: Image.asset('images/dashatar.png')),
                ),
                Container(
                  height: 100,
                  width: 300,
                  color: Colors.teal,
                  child: Center(child: Image.asset('images/dashatar.png')),
                ),
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.brown,
                  child: Center(child: Image.asset('images/dashatar.png')),
                ),
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.red,
                  child: Center(child: Image.asset('images/dashatar.png')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

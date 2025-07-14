import 'dart:isolate';
/// Dart despite being a single threaded language
/// can perform tasks in multiple threads using isolates
/// 
/// An isolate is like a little space on the machine with its own
/// private chunk of memory and a single thread running an event loop
/// 
/// With very heavy computation, can use isolate.spawn() or Flutters' compute 
/// function, whihc create a separate isolate for the computation
/// 
/// The only way multiple isolates can work together is by passing messages
/// back and forth
/// 
/// Memory allocation and garbage collection in an isolate don't require locking
/// Flutter web does not support isolates

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

void multithreadingFunction(int n) {
  int _count = 0;
  for (int i = 0; i < n; i++) {
    _count++;
    if (_count % 2 == 0) {
      print(_count.toString());
    }
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _counter = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Flutter multithreading"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Isolate.spawn(multithreadingFunction, 100);
            setState(() {
              _counter++;
            });
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

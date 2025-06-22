import 'package:flutter/material.dart';
import 'package:new_project/keys/keys.dart';

// import 'package:new_project/ui_updates_demo.dart';

void main() {
  /// final numbers = [1,2,3];
  /// 
  /// Means that this variable is final, can't assign a new value to it
  /// numbers = [4,5,6];
  /// 
  /// But you can still do this, because it uses the existing value stored in memory
  /// and adds a new value to that
  /// numbers.add(4);
  /// 
  /// But with
  /// const numbers = [1,2,3];
  /// numbers.add(4); will not work because const means that the value cannot be manipulated
  /// 
  /// Dart does garbage collection automatically
  /// meaning if objects are not referenced by a variable anymore, that memory slot will be cleared
  
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Internals'),
        ),
        body: const Keys(),
      ),
    );
  }
}
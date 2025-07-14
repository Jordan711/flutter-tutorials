import 'package:flutter/material.dart';
import 'package:mvc_demo/controller.dart';
import 'package:mvc_demo/model.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final Model _model = Model();
  late Controller _controller;

  @override
  void initState() {
    _controller = Controller(_model);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Counter with MVC"), backgroundColor: Colors.tealAccent,),
      body: Center(
        child: Text("${_controller.counter}", style: TextStyle(fontSize: 40.0)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.incrementCounter();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

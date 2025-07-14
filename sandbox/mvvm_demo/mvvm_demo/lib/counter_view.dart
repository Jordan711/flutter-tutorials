import 'package:flutter/material.dart';
import 'package:mvvm_demo/counter_model.dart';
import 'package:mvvm_demo/counter_viewmodel.dart';

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  final CounterViewModel viewModel = CounterViewModel(CounterModel());

  @override
  void initState() {
    viewModel.onCounterChanged = () => setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MVVM")),
      body: Center(
        child: Text(
          "${viewModel.counter}",
          style: const TextStyle(fontSize: 40.0),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}

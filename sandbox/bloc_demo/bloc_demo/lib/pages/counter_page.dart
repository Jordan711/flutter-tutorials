import 'package:bloc_demo/bloc/counter_bloc.dart';
import 'package:bloc_demo/bloc/counter_event.dart';
import 'package:bloc_demo/bloc/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Counter App BLOC')),
      body: BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) {
          return Center(
            child: Text(
              state.value.toString(),
              style: const TextStyle(fontSize: 24.0),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButtons(),
    );
  }
}

class FloatingActionButtons extends StatelessWidget {
  const FloatingActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: () {
            BlocProvider.of<CounterBloc>(context).add(Increment());
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
        SizedBox(height: 10.0),
        FloatingActionButton(
          onPressed: () {
            BlocProvider.of<CounterBloc>(context).add(Decrement());
          },
          tooltip: 'Decrement',
          child: Icon(Icons.remove),
        ),
      ],
    );
  }
}

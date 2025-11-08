library;

import 'package:bloc_exercise/cubit/counter_cubit.dart';
/** 
 * Stream is the foundation of BLOC
 * - It's like a river that transports data from the sender to the receiver
 * - Transported data is asynchronous
 * 
 * Cubit is a minimal version of a BLOC 
 * Bloc extends Cubit
 * 
 * Cubit functions are not part of a stream but a predefined standalone list of 
 * what can be done inside the cubit
 * The one and only stream existing in a cubit is the stream of emitted states
 * 
 * Cubit is a component based on functions that are not part of a stream,
 * emits a stream of states which modify the UI
 * 
 * Bloc not only emits a stream of states but also receives a stream of events
 * - There will be a mapped event to state function, taking an event and then converting it 
 * into a state to return
 * 
 * There should be a block/cubit component for every feature of your app
 * 
 * BlocProvider (Dependency Injection Widget)
 * - Creates and provides a bloc to all of its children in the widget tree
 * - Responsible for creating the bloc, automatically close blocs to prevent stream leaks
 * 
 * BuildContext is the context in which a specific widget is built 
 * 
 * By default, BlocProvider creates the Bloc lazily, 'lazy: false'
 * 
 * When pushing a new screen, the bloc is not going to be available, pass in BlocProvider.value
 * Making the instance of it propagate to through the next widgets
 * 
 * BlocBuilder is a widget that helps rebuilding the UI based on bloc state changes
 * 
 * Pure function is a function where the return value depends only on the function's arguments
 * 
 * BlocListener is a flutter widget that listens to any state change, but instead of rebuilding the widget
 * it takes a simple void function which is called a listener, called once per state
 * 
 * BlocConsumer combines both bloc listener and builder into a widget
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: BlocListener<CounterCubit, CounterState>(
        listener: (context, state) {
          if (state.wasIncremented == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Incremented'),
                duration: Duration(milliseconds: 300),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Decremented'),
                duration: Duration(milliseconds: 300),
              ),
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('You have pushed the button this many times:'),
              BlocBuilder<CounterCubit, CounterState>(
                builder: (context, state) {
                  return Text(
                    state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).increment();
                    },
                    tooltip: "Increment",
                    child: Icon(Icons.add),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).decrement();
                    },
                    tooltip: "Decrement",
                    child: Icon(Icons.remove),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

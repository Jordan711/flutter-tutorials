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
 * 
 * A repository is a class which has the main functions for communicating with the outer data layer
 * 
 * 
 * Architecture: Presentation Layer - Business Logic - Data Layer
 * 
 * Data Layer
 * -Retrieving and manipulating data from one or more sources
 * - network requests, databases etc
 * 
 * Repositories
 * - Model class is instantiated as objects here
 * - A wrapper around one or more data providers
 * 
 * Data Providers
 * - Provide raw data to Repository layer 
 * - Is an API for the application
 * - Direct communication way with the data sources (network requests)
 * 
 * 
 * Models
 * - A blueprint to the data your application will work with
 * - E.g. create the weather model class with all its attributes
 * - Attributes will be a bit linked to the responses from API
 *  - Meaning the models should be generic and universal to multiple data sources (If possibly using other APIs in the future)
 * 
 * Business Logic Layer
 * - Most of the Blocs and Cubits will be created here
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            BlocConsumer<CounterCubit, CounterState>(
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
    );
  }
}

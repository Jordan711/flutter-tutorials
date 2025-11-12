import 'package:bloc_exercise/constants/enums.dart';
import 'package:bloc_exercise/logic/cubit/counter_cubit.dart';
import 'package:bloc_exercise/logic/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.color});

  final String title;
  final Color color;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext homeScreenContext) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (internetCubitListenerContext, state) {
        if (state is InternetConnected &&
            state.connectionType == ConnectionType.wifi) {
          context.read<CounterCubit>().increment();
        } else if (state is InternetConnected &&
            state.connectionType == ConnectionType.mobile) {
          context.read<CounterCubit>().decrement();
        }
      },
      child: Scaffold(
        backgroundColor: widget.color,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<InternetCubit, InternetState>(
                builder: (context, state) {
                  if (state is InternetConnected &&
                      state.connectionType == ConnectionType.wifi) {
                    return Text("Wifi");
                  } else if (state is InternetConnected &&
                      state.connectionType == ConnectionType.mobile) {
                    return Text("Mobile");
                  } else if (state is InternetDisconnected) {
                    return Text("Disconnected");
                  }
                  return CircularProgressIndicator();
                },
              ),
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
                    heroTag: "increment",
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).increment();
                    },
                    tooltip: "Increment",
                    child: Icon(Icons.add),
                  ),
                  FloatingActionButton(
                    heroTag: "decrement",
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).decrement();
                    },
                    tooltip: "Decrement",
                    child: Icon(Icons.remove),
                  ),
                ],
              ),
              SizedBox(height: 24),
              MaterialButton(
                color: widget.color,
                onPressed: () {
                  Navigator.of(context).pushNamed('/second');
                },
                child: Text("Go to second screen"),
              ),

              MaterialButton(
                color: widget.color,
                onPressed: () {
                  Navigator.of(context).pushNamed('/third');
                },
                child: Text("Go to third screen"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

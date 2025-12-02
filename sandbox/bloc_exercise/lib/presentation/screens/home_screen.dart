import 'package:bloc_exercise/constants/enums.dart';
import 'package:bloc_exercise/logic/cubit/counter_cubit.dart';
import 'package:bloc_exercise/logic/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// If I try to access the BlocProvider starting from the context of a screen that
/// doesn't have BlocProvider above in the widget tree, it won't ork
/// I.e. BlocProvider.of() fails to find a context containing the specific bloc/cubit
///
/// Also, cannot access a bloc or cubit instance from the same context in which it was provided
/// Need to call BlocProvider.of() in child contexts only
///
/// Widget Tree
/// CTRL Shift P
/// Dev Tools
///
/// BLOC 6.1
/// Multi Bloc Builder - rebuild a wdiget based on multiple blocs or cubit states
///
/// context.watch<BlocA>()
/// From the widget that was built within the context BuildContext
/// Start searching for the unique instance of BlocA, provided above in the widget tree, then
/// After it is found, watch or subscribe to its stream of emitted states
/// Whenever a new state is emitted by BlocA
/// Rebuild the widget from which the lookup was started
///
/// Store the different Bloc states in each variable
/// final blocAState = context.watch<BlocA>().state;
/// final blocBState = context.watch<BlocB>().state;
/// final blocCState = context.watch<BlocC>().state;
///
/// return MyWidget(blocAState, blocBState, blocCState);
///
/// Entire widget of context will be rebuilt
/// 
/// Misunderstood context.bloc
/// Wrong: USe context.bloc.state and then updating it in widget
/// Never know when Flutter Engine decides to call the build method
/// Wont' know at which moment in time or which of the states, the bloc/cubit will get
/// Can render widgets with wrong information
/// 
/// Inside the UI, you should listen to the incoming stream of states
/// You should not randomly pick one of the states at a random moment in time
/// context.bloc replaced by BlocProvider.of(context) or context.read()
/// context.read() is a way to read/access a provided instance of bloc/cubit inside the widget tree
/// Won't rebuild widget from where you'll start searching for the bloc/cubit instance
/// Should be called only when you need it, and only where you need it
/// 
/// Never mutate existing state
/// Bloc won't consecutively emit 2 identical states
/// emit(state.copyWith(blah: newValue));

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
    return Scaffold(
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

            SizedBox(height: 24.0),
            Builder(
              builder: (context) {
                final counterState = context.watch<CounterCubit>().state;
                final internetState = context.watch<InternetCubit>().state;

                if (internetState is InternetConnected &&
                    internetState.connectionType == ConnectionType.mobile) {
                  return Text(
                    "Counter: ${counterState.counterValue} Internet: Mobile",
                    style: Theme.of(context).textTheme.headlineLarge,
                  );
                } else if (internetState is InternetConnected &&
                    internetState.connectionType == ConnectionType.wifi) {
                  return Text(
                    "Counter: ${counterState.counterValue} Internet: WIFI",
                    style: Theme.of(context).textTheme.headlineLarge,
                  );
                } else {
                  return Text(
                    "Counter: ${counterState.counterValue} Internet: Disconnected",
                    style: Theme.of(context).textTheme.headlineLarge,
                  );
                }
              },
            ),
            SizedBox(height: 24),
            Builder(builder: (context) {
              final counterValue = context.select((CounterCubit cubit) => cubit.state.counterValue);

              return Text("Counter: $counterValue", style: Theme.of(context).textTheme.headlineLarge);
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: "increment",
                  onPressed: () {
                    context.read<CounterCubit>().increment();
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

            // Start looking from the homeScreenContext, and when we find the Navigator Instance
            // We push the screen
            MaterialButton(
              color: widget.color,
              onPressed: () {
                // Search for the closest Navigator instance inside the widget tree
                // Starting from this exact BuildContext
                // Then from the context in which the Navigator Instance was found, push the desired new screen inside it's own context

                // MaterialButton is built with an anonymous context, and cannot be accessed
                // Anonymous context remains anonymous but Builder widget creates ana ccessible context right above
                // the widget you want the lookup to start from

                // materialButtonContext is the context in which the Builder widget was created.
                // MAterial button is still built within an anonymous context
                Navigator.of(homeScreenContext).pushNamed('/second');
              },
              child: Text("Go to second screen"),
            ),

            // Start searching for a Navigator Instance, right from materialButtonContext BuildContext
            // Push /second screen from the context, where it will be found
            // MaterialApp has Navigator in its core functionality
            Builder(
              builder: (materialButtonContext) {
                return MaterialButton(
                  color: widget.color,
                  onPressed: () {
                    // Search for the closest Navigator instance inside the widget tree
                    // Starting from this exact BuildContext
                    // Then from the context in which the Navigator Instance was found, push the desired new screen inside it's own context

                    // MaterialButton is built with an anonymous context, and cannot be accessed
                    // Anonymous context remains anonymous but Builder widget creates ana ccessible context right above
                    // the widget you want the lookup to start from

                    // materialButtonContext is the context in which the Builder widget was created.
                    // MAterial button is still built within an anonymous context
                    Navigator.of(materialButtonContext).pushNamed('/second');
                  },
                  child: Text("Go to second screen"),
                );
              },
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
    );
  }
}

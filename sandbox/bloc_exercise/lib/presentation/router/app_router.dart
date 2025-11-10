import 'package:bloc_exercise/presentation/screens/home_screen.dart';
import 'package:bloc_exercise/presentation/screens/second_screen.dart';
import 'package:bloc_exercise/presentation/screens/third_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => MyHomePage(
            title: 'Flutter Demo Home Page',
            color: Colors.blueAccent,
          ),
        );
      case '/second':
        return MaterialPageRoute(
          builder: (_) => SecondScreen(
            title: 'Second Screen',
            color: Colors.redAccent,
          ),
        );
      case '/third':
        return MaterialPageRoute(
          builder: (_) => ThirdScreen(
            title: 'Third Screen',
            color: Colors.greenAccent,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => MyHomePage(
            title: 'Flutter Demo Home Page',
            color: Colors.blueAccent,
          ),
        );
    }
  }
}

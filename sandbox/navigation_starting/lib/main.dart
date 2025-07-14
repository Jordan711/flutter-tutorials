import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_starting/about_web.dart';
import 'package:navigation_starting/home_web.dart';
// import 'package:navigation_starting/about_web.dart';
// import 'package:navigation_starting/home_web.dart';


// Deep linking is the ability to open a specific screen within
// the app directly from an external source

// Defining a unique URL scheme for the app and handling the incoming URLs
// Go Router
import 'package:url_strategy/url_strategy.dart';

import 'routes.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // routerConfig: router,
      // routes: {
      //   '/': (_) => HomeWeb(),
      //   '/about': (_) => AboutWeb(
      //         text: "Paulina Knop",
      //       ),
      // },
      onGenerateRoute: (settings) => Routes.generateRoute(settings),
      initialRoute: '/',
    );
  }
}

// GoRouter router = GoRouter(
//   routes: [
//     GoRoute(path: '/about', builder: (context, state) => AboutWeb(text: "Text")),
//     GoRoute(path: '/', builder: (context, state) => HomeWeb())
//   ]
// );
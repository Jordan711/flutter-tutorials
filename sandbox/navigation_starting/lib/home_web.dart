import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:navigation_starting/about_web.dart';

class HomeWeb extends StatefulWidget {
  const HomeWeb({Key? key}) : super(key: key);

  @override
  _HomeWebState createState() => _HomeWebState();
}

class _HomeWebState extends State<HomeWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Home Web",
              style: TextStyle(fontSize: 40.0),
            ),
            MaterialButton(
              color: Colors.cyan,
              onPressed: () {
                // context.go("/about");
                Navigator.of(context).pushNamed('/about', arguments: "Bob the builder");

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => AboutWeb(text: "lmao",),
                //   ),
                // );

                // Navigator.of(context)
                //     .pushNamed('/about', arguments: "Paulina Knop");
              },
              child: const Text(
                "Go to about",
                style: TextStyle(fontSize: 40.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}

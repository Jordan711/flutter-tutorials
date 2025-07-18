import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AboutWeb extends StatefulWidget {
  final String text;
  const AboutWeb({Key? key, this.text=""}) : super(key: key);

  @override
  _AboutWebState createState() => _AboutWebState();
}

class _AboutWebState extends State<AboutWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "About web",
              style: TextStyle(fontSize: 40.0),
            ),
            Text(
              "${widget.text.toString()}",
              style: TextStyle(fontSize: 40.0),
            ),
            MaterialButton(
              color: Colors.cyan,
              onPressed: () {
                Navigator.pop(context);
                // context.go("/");
              },
              child: const Text(
                "Go back",
                style: TextStyle(fontSize: 40.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}

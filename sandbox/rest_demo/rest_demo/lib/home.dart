import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rest_demo/components.dart';

Dio dio = Dio();

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MaterialButton(onPressed: () async {
            final response = await dio.get("https://jsonplaceholder.typicode.com/comments");
            logger.d(response);
            logger.d(response.headers);
            logger.d(response.statusCode);
            logger.d(response.data);
          },
          child: Text("Get Response"),)
        ],
      )
    );
  }
}
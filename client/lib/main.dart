import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:client/screens/HomePage.dart';
import 'package:client/screens/test.dart';
import 'package:client/screens/ytApiTest.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());

  doWhenWindowReady(() {
    final initialSize = Size(1080, 1920); //Size(75.7, 150.9);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toxicity Searcher',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(), //YtApiTest(), // HomePage,
    );
  }
}

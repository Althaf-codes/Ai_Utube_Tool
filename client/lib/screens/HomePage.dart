import 'package:client/screens/ToxicityTextScreen.dart';
import 'package:client/screens/YoutubeCommentScreen.dart';
import 'package:client/screens/constants.dart';
import 'package:client/screens/ytApiTest.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final elevation = 3.0;
  int _currentIndex = 0;
  List<Widget> body = [const ToxicityText(), const YtApiTest()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body[_currentIndex],
      bottomNavigationBar: Container(
          height: 100,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              //border: Border.all(color: Colors.red),
              boxShadow: [
                BoxShadow(
                    color: Colors.red,
                    spreadRadius: 2.0,
                    blurRadius: elevation,
                    offset: const Offset(-3.0, -3.0)),
                BoxShadow(
                    color: Colors.red,
                    spreadRadius: 2.0,
                    blurRadius: elevation / 2,
                    offset: const Offset(-3.0, -3.0)),
              ]),
          child: BottomNavigationBar(
              backgroundColor: backgroundColor,
              currentIndex: _currentIndex,
              selectedItemColor: activeBottomIconColor,
              unselectedItemColor: inactiveBottomIconColor,
              onTap: (int activeIndex) {
                setState(() {
                  _currentIndex = activeIndex;
                });
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.send), label: 'TextSearch'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.text_fields), label: 'CommentSearch'),
                // BottomNavigationBarItem(
                //     icon: Icon(Icons.text_fields), label: '1st'),
              ])),
    );
  }
}

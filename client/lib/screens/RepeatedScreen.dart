import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class RepeatedScreen extends StatefulWidget {
  List<String> repeatedUserName = [];
  List<String> repeatedUserImg = [];
  List<String> repeatedUserTc = [];
  RepeatedScreen(
      {Key? key,
      required this.repeatedUserName,
      required this.repeatedUserImg,
      required this.repeatedUserTc})
      : super(key: key);

  @override
  _RepeatedScreenState createState() => _RepeatedScreenState();
}

class _RepeatedScreenState extends State<RepeatedScreen> {
  ScrollController _scrollController = ScrollController();

  Future<Null> deleteRepeatedUser() async {
    final Uri url = Uri.parse('http://localhost:8080/api/delete/user');

    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        print('Tracker Reset Success');
      }
    } catch (err) {
      print('err in repeatedUser was ${err}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  widget.repeatedUserImg = [];
                  widget.repeatedUserName = [];
                  widget.repeatedUserTc = [];
                  deleteRepeatedUser();
                });
              },
              icon: Icon(Icons.delete_forever),
              label: const Text(
                'Remove Tracker',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w300),
              ),
            )
          ],
        ),
        backgroundColor: Colors.black,
        body: Container(
          child: widget.repeatedUserName.isNotEmpty
              ? ListView.builder(
                  controller: _scrollController,
                  itemCount: widget.repeatedUserName.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Image.network(widget.repeatedUserImg[index]),
                        backgroundColor: Colors.white,
                      ),
                      title: Text(
                        widget.repeatedUserName[index],
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      // subtitle: Text(
                      //   widget.repeatedUserTc[index],
                      //   style: TextStyle(color: Colors.white, fontSize: 12),
                      // ),
                    );
                  },
                )
              : const Center(
                  child: Text(
                    'No Repeated Haters',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w300),
                  ),
                ),
        ));
  }
}

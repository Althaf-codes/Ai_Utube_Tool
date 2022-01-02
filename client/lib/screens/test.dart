import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  ScrollController _controller = ScrollController();
  List<String> allRepeatedUserName = [];
  List<String> allRepeatedUserImg = [];
  List<String> allRepeatedUserTc = [];
  List<String> repeatedUserName = [];
  List<String> repeatedUserImg = [];
  List<String> repeatedUserTc = [];

  List<Map> repeatedUserArray = [
    {
      "name": "Githendra 2001",
      "img":
          "https://yt3.ggpht.com/ytc/AKedOLSajHfZOAsomWXF0QBRT7WBaj9Z0Xl0kWvPrg=s48-c-k-c0x00ffffff-no-rj",
      "tc": "Dont upload shit video"
    },
    {
      "name": "Emperor Althaf",
      "img":
          "https://yt3.ggpht.com/ytc/AKedOLTuztvM4QPKKJ42gs9VQYVdWj5ogQIdhvZJ0KNPRrrgS5yFsAB5_jZ8aid_HUJB=s48-c-k-c0x00ffffff-no-rj",
      "tc": "this is simply stupid please for god sake dont upload this shit"
    },
    {
      "name": 'althafar ali jaffar ali',
      "img":
          'https://yt3.ggpht.com/ytc/AKedOLQ8ca4ggYr2qXAWBLfPy0u167dxbBKDvoQVxA_Z=s48-c-k-c0x00ffffff-no-rj',
      "tc": "Simply sucks"
    }
  ];
  Map<String, dynamic> repeatedUserMap = {};

  Future<Null> saveRepeatedUser(List<Map> details) async {
    final Uri url = Uri.parse('http://localhost:8080/api/repeated/user');

    final data = jsonEncode(<String, dynamic>{'Details': details});
    print('the data is :');
    print(data);
    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: data);

      if (response.statusCode == 200) {
        print('Repeated User Data saved');
      }
    } catch (err) {
      print('err in repeatedUser was ${err}');
    }
  }

  Future<Null> getRepeatedUser() async {
    final Uri url = Uri.parse('http://localhost:8080/api/getRepeated/users');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('the received data is');
        print(data);

        int totallen = data.length;
        print(totallen);
        int detailslen = data[0]['Details'].length;
        print(detailslen);
        int i = 0;
        int j = 0;
        for (i = 0; i < totallen; i++) {
          for (j = 0; j < data[i]['Details'].length; j++) {
            var name = data[i]['Details'][j]['name'].toString();
            var img = data[i]['Details'][j]['img'].toString();
            var tc = data[i]['Details'][j]['tc'].toString();

            allRepeatedUserName.add(name);
            allRepeatedUserImg.add(img);
            allRepeatedUserTc.add(tc);
          }
        }
        for (i = 0; i < allRepeatedUserName.length; i++) {
          for (j = i + 1; j < allRepeatedUserName.length; j++) {
            if (allRepeatedUserName[i] == allRepeatedUserName[j]) {
              repeatedUserName.add(allRepeatedUserName[j]);
              repeatedUserImg.add(allRepeatedUserImg[j]);
              repeatedUserTc.add(allRepeatedUserTc[j]);
            }
          }
        }

        print(repeatedUserName);
        print(repeatedUserImg);
        print(repeatedUserTc);
      }
      if (response.statusCode == 404) {
        print('User not found');
      }
    } catch (err) {
      print('err in getRepeatedUser was ${err} ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      color: Colors.red,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // saveRepeatedUser(details)
                          // int i = 0;
                          // for (i = 0;
                          //     i < toxicityarray.length;
                          //     i++) {
                          //   repeatedUserMap = {
                          //     "name": userToxicNameArray[i],
                          //    "img": userToxicImageArray[i],
                          //     'tc': userToxicCommentArray[i]
                          //   };
                          //   repeatedUserArray.add(repeatedUserMap);
                          // }
                          // print('repeatedUserArray :');
                          // print(repeatedUserArray);
                          saveRepeatedUser(repeatedUserArray);
                          setState(() {});
                        },
                        icon: Icon(Icons.track_changes),
                        label: const Text(
                          'Track User',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.red,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          getRepeatedUser();
                          setState(() {});
                        },
                        icon: Icon(Icons.track_changes),
                        label: const Text(
                          'get User',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: 10, // toxicityarray.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(index.toString()),
                          // child: Image.network(
                          //     userToxicImageArray[index]),
                          // backgroundColor: Colors.white,
                        ),
                        title: Text(
                          index.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        subtitle: Text(
                          index.toString(),
                          //toxicityarray[index],
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

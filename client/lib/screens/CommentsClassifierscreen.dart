import 'dart:async';
import 'dart:ui';

import 'package:client/screens/RepeatedScreen.dart';
import 'package:client/screens/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
// import 'package:fluttertoast/fluttertoast.dart';
import 'ClassifierScreen.dart';

class CommentsClassifierScreen extends StatefulWidget {
  List<String> userCommentArray;
  List<String> userNameArray;
  List<String> userImageArray;
  CommentsClassifierScreen(
      {Key? key,
      required this.userCommentArray,
      required this.userImageArray,
      required this.userNameArray})
      : super(key: key);

  @override
  _CommentsClassifierScreenState createState() =>
      _CommentsClassifierScreenState();
}

class _CommentsClassifierScreenState extends State<CommentsClassifierScreen> {
  ScrollController _scrollcontroller = ScrollController();
  bool isloading1 = false;
  bool isReached1 = false;
  bool isTrackable = false;
  bool canTrack = false;
  bool toviewTrack = false;
  var sentenceArray;
  var isToxic;
  List<String> usedSentence = [];
  List<String> singleLabel = [];
  List<List<String>> allLabels = [];
  List<String> toxicityarray = [];
  List<String> insultArray = [];
  List<String> obsceneArray = [];
  List<String> severeToxicityarray = [];
  List<String> sexualExplicitArray = [];
  List<String> threatArray = [];
  List<String> identityAttackArray = [];
  List<String> userToxicCommentArray = [];
  List<String> userToxicImageArray = [];
  List<String> userToxicNameArray = [];
  List<Map> repeatedUserArray = [];
  Map<String, dynamic> repeatedUserMap = {};
  List<String> allRepeatedUserName = [];
  List<String> allRepeatedUserImg = [];
  List<String> allRepeatedUserTc = [];
  List<String> repeatedUserName = [];
  List<String> repeatedUserImg = [];
  List<String> repeatedUserTc = [];
  final snackBar1 = SnackBar(
    duration: const Duration(seconds: 2),
    content: const Text('Tracker Added !'),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    backgroundColor: Colors.red,
  );
  final snackBar2 = SnackBar(
    duration: const Duration(seconds: 2),
    content: const Text('Data cleared'),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
    backgroundColor: Colors.red,
  );
  Future<Null> fetchMultiData(String sentence) async {
    setState(() {
      isloading1 = true;
      print('isloading 2nd');
      print(isloading1);
      isReached1 = false;
    });
    final Uri url = Uri.parse('http://localhost:8080/api/values/${sentence}');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);

        int totallen = data.length;
        // int len = data[0].length;
        print('total length is:');
        print(totallen);

        if (totallen > 0) {
          int i = 0;
          int j = 0;
          for (i = 0; i < totallen; i++) {
            //  var singleSent = data.Sentence[i];
            for (j = 0; j < data[i].length; j++) {
              var toxicPresent =
                  data[i][data[i].length - 1]['label'].toString();
              print('toxicpresent is');
              print(toxicPresent);
              if (toxicPresent == 'toxicity') {
                singleLabel.add(data[i][j]['label']);
              }

              //  bool iscontain=label.contains('toxicity');
              //   print(singleLabel);
            }
            print('after 1st loop');
            print(singleLabel);
            // singleLabel.add(singleLabel);
            // print(singleLabel);
            allLabels.add(singleLabel);
            setState(() {
              singleLabel = [];
            });
            print('all label is:');
            print(allLabels);
            // print('isToxicArray');
            // print(isToxicArray);
          }
          //var value = data[0][1]['label'];
        } else {
          setState(() {
            isToxic = 'false';
          });
        }

        print('all label length is:');
        print(allLabels.length);

        if (allLabels.length > 0) {
          int i = 0;
          for (i = 0; i < allLabels.length; i++) {
            bool isInsult = allLabels[i].contains('insult');
            bool isToxicity = allLabels[i].contains('toxicity');
            bool isObscene = allLabels[i].contains('obscene');
            bool isSexualexplicit = allLabels[i].contains('sexual_explicit');
            bool isThreat = allLabels[i].contains('threat');
            bool isIdentityattack = allLabels[i].contains('identity_attack');
            bool isSevereToxicity = allLabels[i].contains('severe_toxicity');

            if (isToxicity) {
              toxicityarray.add(widget.userCommentArray[i]);
              userToxicCommentArray.add(widget.userCommentArray[i]);
              userToxicImageArray.add(widget.userImageArray[i]);
              userToxicNameArray.add(widget.userNameArray[i]);
              if (isInsult) {
                insultArray.add(widget.userCommentArray[i]);
              }
              ;
              if (isObscene) {
                obsceneArray.add(widget.userCommentArray[i]);
              }
              ;
              if (isSexualexplicit) {
                sexualExplicitArray.add(widget.userCommentArray[i]);
              }
              ;
              if (isThreat) {
                threatArray.add(widget.userCommentArray[i]);
              }
              ;
              if (isIdentityattack) {
                identityAttackArray.add(widget.userCommentArray[i]);
              }
              ;
              if (isIdentityattack) {
                identityAttackArray.add(widget.userCommentArray[i]);
              }
              ;
              if (isSevereToxicity) {
                severeToxicityarray.add(widget.userCommentArray[i]);
              }
              ;
            } else if (isInsult) {
              insultArray.add(widget.userCommentArray[i]);
            } else if (isObscene) {
              obsceneArray.add(widget.userCommentArray[i]);
            } else if (isSexualexplicit) {
              sexualExplicitArray.add(widget.userCommentArray[i]);
            } else if (isThreat) {
              threatArray.add(widget.userCommentArray[i]);
            } else if (isIdentityattack) {
              identityAttackArray.add(widget.userCommentArray[i]);
            } else if (isSevereToxicity) {
              severeToxicityarray.add(widget.userCommentArray[i]);
            }
          }
        }
        print('insultArray');
        print(insultArray);
        print('toxicityArray');
        print(toxicityarray);
        print('obscene aray');
        print(obsceneArray);
        print('sexualexplicitarray');
        print(sexualExplicitArray);
        print('identityAttackarray');
        print(identityAttackArray);
        print('severeToxicityarray');
        print(severeToxicityarray);
        print('threatArray');
        print(threatArray);
        print('userToxicImageArray');
        print(userToxicImageArray);
        print('userToxicNameArray');
        print(userToxicNameArray);
        print('userToxicCommentsArray');
        print(userToxicCommentArray);
        setState(() {
          isReached1 = true;
          isloading1 = false;
          print('isloading last');
          print(isloading1);
        });
      } else {
        setState(() {
          isToxic = 'false';
        });
      }
    } catch (err) {
      print('err was ${err}');
    }
  }

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

        if (totallen > 0) {
          setState(() {
            canTrack = true;
          });
        }
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
        print('setting:');
        print(repeatedUserName.toSet());
        print(repeatedUserImg.toSet());
        print(repeatedUserTc.toSet());
        setState(() {
          isTrackable = true;
        });
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
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: isloading1
              ? const Text(
                  'Classifying...',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                )
              : isReached1
                  ? Text('Toxic coments : ${toxicityarray.length}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w300))
                  : const Text(
                      'Classifier screen',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w300),
                    ),
          actions: [
            isReached1
                ? ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Classifier(
                                    insultArray: insultArray,
                                    toxicityArray: toxicityarray,
                                    threatArray: threatArray,
                                    sexualExplicitArray: sexualExplicitArray,
                                    obsceneArray: obsceneArray,
                                    severeToxicityArray: severeToxicityarray,
                                    identityAttackArray: identityAttackArray,
                                  )));
                    },
                    icon: Icon(Icons.filter_list_alt),
                    label: const Text(
                      'Filter',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w300),
                    ),
                  )
                : Container(),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  isReached1 = false;
                  toxicityarray = [];
                  insultArray = [];
                  obsceneArray = [];
                  severeToxicityarray = [];
                  sexualExplicitArray = [];
                  threatArray = [];
                  identityAttackArray = [];
                  singleLabel = [];
                  allLabels = [];
                  userToxicCommentArray = [];
                  userToxicImageArray = [];
                  userToxicNameArray = [];
                  repeatedUserArray = [];
                  repeatedUserMap = {};
                  allRepeatedUserName = [];
                  allRepeatedUserImg = [];
                  allRepeatedUserTc = [];
                  repeatedUserName = [];
                  repeatedUserImg = [];
                  repeatedUserTc = [];
                });
              },
              icon: Icon(Icons.delete_forever),
              label: const Text(
                'clear',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w300),
              ),
            )
          ],
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          isloading1
              ? Container(
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                          backgroundColor: Colors.white, color: redcolor),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("PROCESSING...",
                          style: TextStyle(
                              color: Colors.red,
                              letterSpacing: 1.0,
                              fontSize: 12,
                              fontWeight: FontWeight.bold))
                    ],
                  )),
                )
              : isReached1
                  ? toxicityarray.isEmpty
                      ? const Center(
                          child: Text('No Toxic Comments',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)))
                      : Expanded(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    color: Colors.red,
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        // saveRepeatedUser(details)
                                        int i = 0;
                                        for (i = 0;
                                            i < toxicityarray.length;
                                            i++) {
                                          repeatedUserMap = {
                                            "name": userToxicNameArray[i]
                                                .toString(),
                                            "img": userToxicImageArray[i]
                                                .toString(),
                                            "tc": userToxicCommentArray[i]
                                                .toString()
                                          };
                                          repeatedUserArray
                                              .add(repeatedUserMap);
                                        }
                                        print('repeatedUserArray :');
                                        print(repeatedUserArray);
                                        saveRepeatedUser(repeatedUserArray);

                                        // ScaffoldMessengerState()
                                        //     .showSnackBar(snackBar1);
                                        setState(() {
                                          toviewTrack = true;
                                        });
                                      },
                                      icon: Icon(Icons.track_changes),
                                      label: const Text(
                                        'Add Tracker',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  toviewTrack
                                      ? Container(
                                          color: Colors.red,
                                          child: ElevatedButton.icon(
                                            onPressed: () {
                                              getRepeatedUser();
                                              setState(() {});
                                            },
                                            icon: Icon(Icons.view_in_ar),
                                            label: const Text(
                                              'View Tracker',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  canTrack
                                      ? Container(
                                          color: Colors.red,
                                          child: ElevatedButton.icon(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RepeatedScreen(
                                                              repeatedUserName:
                                                                  repeatedUserName
                                                                      .toSet()
                                                                      .toList(),
                                                              repeatedUserImg:
                                                                  repeatedUserImg
                                                                      .toSet()
                                                                      .toList(),
                                                              repeatedUserTc:
                                                                  repeatedUserTc)));
                                            },
                                            icon: Icon(Icons.arrow_forward_ios),
                                            label: const Text(
                                              'Get Data',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                        )
                                      : Container()
                                ],
                              ),
                              Expanded(
                                  child: ListView.builder(
                                controller: _scrollcontroller,
                                itemCount: toxicityarray.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: CircleAvatar(
                                      child: Image.network(
                                          userToxicImageArray[index]),
                                      backgroundColor: Colors.white,
                                    ),
                                    title: Text(
                                      userToxicNameArray[index],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                    subtitle: Text(
                                      toxicityarray[index],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  );
                                },
                              )),
                            ],
                          ),
                        )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Click to Classify',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2),
                        ),
                        GestureDetector(
                          onTap: () {
                            fetchMultiData(widget.userCommentArray.toString());
                          },
                          child: Center(
                              child: Container(
                                  height: 50,
                                  width: 100,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.red)),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text(
                                          'Classify',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Icon(
                                          Icons.arrow_circle_down_outlined,
                                          color: Colors.red,
                                        ),
                                      ]))),
                        )
                      ],
                    ),
        ]));
  }
}

      //  ListView.builder(
      //     itemCount: 10,
      //     itemBuilder: (context, index) {
      //       return Container();
      //     }),
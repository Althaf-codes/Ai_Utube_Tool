import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:client/screens/ClassifierScreen.dart';
import 'package:client/screens/constants.dart';
import 'package:flutter/material.dart';

class YoutubeComment extends StatefulWidget {
  const YoutubeComment({Key? key}) : super(key: key);

  @override
  State<YoutubeComment> createState() => _YoutubeCommentState();
}

class _YoutubeCommentState extends State<YoutubeComment> {
  bool isloading = false;

  bool isReached = false;
  var isToxic;
  List<String> usedSentence = [];
  List<String> singleLabel = [];
  List<List<String>> allLabels = [];
  var sentenceArray;
  List<String> toxicityarray = [];
  List<String> insultArray = [];
  List<String> obsceneArray = [];
  List<String> severeToxicityarray = [];
  List<String> sexualExplicitArray = [];
  List<String> threatArray = [];
  List<String> identityAttackArray = [];
  // List<String> isToxicArray = [];
  @override
  Widget build(BuildContext context) {
    const elevation = 3.0;
    ScrollController _scrollcontroller = ScrollController();
    TextEditingController _youtubeSearchController = TextEditingController();

    // List<String> singleLabel) = [];

    Future<Null> fetchMultiData(String sentence) async {
      setState(() {
        isloading = true;
        print('isloading 2nd');
        print(isloading);
        isReached = false;
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
              toxicityarray.add(usedSentence[i]);
              if (isInsult) {
                insultArray.add(usedSentence[i]);
              }
              ;
              if (isObscene) {
                obsceneArray.add(usedSentence[i]);
              }
              ;
              if (isSexualexplicit) {
                sexualExplicitArray.add(usedSentence[i]);
              }
              ;
              if (isThreat) {
                threatArray.add(usedSentence[i]);
              }
              ;
              if (isIdentityattack) {
                identityAttackArray.add(usedSentence[i]);
              }
              ;
              if (isIdentityattack) {
                identityAttackArray.add(usedSentence[i]);
              }
              ;
              if (isSevereToxicity) {
                severeToxicityarray.add(usedSentence[i]);
              }
              ;
            } else if (isInsult) {
              insultArray.add(usedSentence[i]);
            } else if (isObscene) {
              obsceneArray.add(usedSentence[i]);
            } else if (isSexualexplicit) {
              sexualExplicitArray.add(usedSentence[i]);
            } else if (isThreat) {
              threatArray.add(usedSentence[i]);
            } else if (isIdentityattack) {
              identityAttackArray.add(usedSentence[i]);
            } else if (isSevereToxicity) {
              severeToxicityarray.add(usedSentence[i]);
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

          setState(() {
            isReached = true;
            isloading = false;
            print('isloading last');
            print(isloading);
          });
        } else {
          setState(() {
            isToxic = 'false';
          });
        }
      } catch (err) {
        print(err);
      }
    }

    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Youtube Comment Searcher',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.red),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                tooltip: 'Search',
                icon: Icon(
                  Icons.search_rounded,
                  color: redcolor,
                ))
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 200,
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100),
                      bottomLeft: Radius.circular(20)),
                  // border: Border.all(color: Colors.red),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.red,
                        blurRadius: 0.5,
                        offset: Offset(5, 0),
                        spreadRadius: 5),
                    BoxShadow(
                        color: Colors.red,
                        blurRadius: 0.5,
                        offset: Offset(5, 0))
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Get youtube Comments ,',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Expanded(
                      child: Text(
                    'And classify the comments based on toxicity',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.black,
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black54,
                                spreadRadius: 0.0,
                                blurRadius: elevation,
                                offset: Offset(3.0, 3.0)),
                            BoxShadow(
                                color: Colors.black54,
                                spreadRadius: 0.0,
                                blurRadius: elevation / 2.0,
                                offset: Offset(3.0, 3.0)),
                            // BoxShadow(
                            //     color: Colors.grey,
                            //     spreadRadius: 2.0,
                            //     blurRadius: elevation,
                            //     offset: const Offset(-3.0, -3.0)),
                            // BoxShadow(

                            //     color: Colors.grey,
                            //     spreadRadius: 2.0,
                            //     blurRadius: elevation / 2,
                            //     offset: const Offset(-3.0, -3.0)),
                          ],
                        ),
                        child: TextField(
                          controller: _youtubeSearchController,
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                            filled: true,
                            focusColor: Colors.green,
                            hoverColor: Colors.black,
                            hintText: 'i.e Enter a sentence',
                            contentPadding: EdgeInsets.all(8),
                            fillColor: Colors.red,
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontWeight: FontWeight.w100),
                            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: OutlineInputBorder),
                          ),
                          onSubmitted: (val) {
                            print('the textfeild value is ${val}');
                            fetchMultiData(val.toString());

                            sentenceArray = val.toString();

                            isloading = true;
                            print('isloading 1');
                            print(isloading);
                            // var strSentence = sentenceArray.toString();
                            var singleSentence = sentenceArray.split(',');
                            int i = 0;
                            for (i = 0; i < singleSentence.length; i++) {
                              var sentence = singleSentence[i];
                              usedSentence.add(sentence);
                            }
                            print('singleSentence is :');
                            print(singleSentence);
                            print('used sentences are');
                            print(usedSentence);
                            _youtubeSearchController.clear();

                            setState(() {});
                          },
                        )),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            // isloading
            //     ? Container(
            //         child: const Text(
            //           'it is loading',
            //           style: TextStyle(color: Colors.white),
            //         ),
            //       )
            //     : Container(
            //         child: const Text(
            //           'loading done',
            //           style: TextStyle(color: Colors.white),
            //         ),
            //       )
            isloading
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
                : isReached
                    ? Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              'Toxic Comments',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isReached = false;
                                  toxicityarray = [];
                                  insultArray = [];
                                  obsceneArray = [];
                                  severeToxicityarray = [];
                                  sexualExplicitArray = [];
                                  threatArray = [];
                                  identityAttackArray = [];
                                  usedSentence = [];
                                  singleLabel = [];
                                  allLabels = [];
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.red)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      'Clear',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Classifier(
                                              insultArray: insultArray,
                                              toxicityArray: toxicityarray,
                                              threatArray: threatArray,
                                              sexualExplicitArray:
                                                  sexualExplicitArray,
                                              obsceneArray: obsceneArray,
                                              severeToxicityArray:
                                                  severeToxicityarray,
                                              identityAttackArray:
                                                  identityAttackArray,
                                            )));
                              },
                              child: Container(
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
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.red,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.all(12),
                        child: const Text(
                          'Enter multiple sentence/comments',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        )),

            // const SizedBox(
            //   height: 10,
            // ),

            isloading
                ? Container()
                : isReached
                    ? Expanded(
                        child: ListView.builder(
                        controller: _scrollcontroller,
                        itemCount: toxicityarray.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(color: Colors.black),
                                ),
                              )),
                              backgroundColor: Colors.red,
                            ),
                            title: Text(
                              'User${index + 1}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            subtitle: Text(
                              toxicityarray[index],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          );
                        },
                      ))
                    : Container(
                        child: const Text(
                        'Nothing to show',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w200),
                      ))
          ],
        ));
  }
}
//  const TabBar(tabs: [
//             Tab(
//               text: 'Top Comments',
//             ),
//             Tab(
//               text: 'Toxicity classifer',
//             ),
//           ])


/*
TextEditingController _youtubeSearchController = TextEditingController();
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(12)),
                border: Border.all(color: Colors.black),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black,
                      blurRadius: 0.5,
                      offset: Offset(5, 0)),
                  BoxShadow(
                      color: Colors.red, blurRadius: 0.5, offset: Offset(5, 0))
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Digital cop',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                Container()
              ],
            )),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Get Youtube Comments',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.red,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.red.shade400,
                        spreadRadius: 0.0,
                        blurRadius: elevation,
                        offset: const Offset(3.0, 3.0)),
                    BoxShadow(
                        color: Colors.red.shade400,
                        spreadRadius: 0.0,
                        blurRadius: elevation / 2.0,
                        offset: const Offset(3.0, 3.0)),
                    // BoxShadow(
                    //     color: Colors.grey,
                    //     spreadRadius: 2.0,
                    //     blurRadius: elevation,
                    //     offset: const Offset(-3.0, -3.0)),
                    // BoxShadow(
                    //     color: Colors.grey,
                    //     spreadRadius: 2.0,
                    //     blurRadius: elevation / 2,
                    //     offset: const Offset(-3.0, -3.0)),
                  ],
                ),
                child: TextField(
                  controller: _youtubeSearchController,
                  cursorColor: Colors.red,
                  decoration: const InputDecoration(
                    filled: true,
                    //focusColor: Colors.green,
                    hoverColor: Colors.red,
                    hintText: 'i.e Enter a video url',
                    contentPadding: EdgeInsets.all(8),
                    fillColor: Colors.black,
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.w100),
                    // border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: OutlineInputBorder),
                  ),
                  onSubmitted: (val) {
                    print('the textfeild value is ${val}');
                    _youtubeSearchController.clear();
                  },
                )),
          ),
*/ 
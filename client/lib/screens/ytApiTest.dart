import 'dart:convert';
import 'dart:io';
import 'package:client/SecretConstant.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:client/screens/CommentsClassifierscreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:translator/translator.dart';
import 'constants.dart';

class YtApiTest extends StatefulWidget {
  // String ChannelId;

  const YtApiTest({Key? key}) : super(key: key);

  @override
  _YtApiTestState createState() => _YtApiTestState();
}

class _YtApiTestState extends State<YtApiTest> {
  // static const CHANNEL_ID = 'Uv7cIJAymSs';
  // static const _baseUrl = 'https://www.googleapis.com';
  // static const API_KEY = 'AIzaSyCIGBnNlaUgJEfDBBHDL2qYqgoN8CkW0sk';
  var translatedcomment;
  bool isloading = false;
  bool isReached = false;

  bool istranslate = false;

  // late YoutubePlayerController _controller;
  TextEditingController _searchController = TextEditingController();
  List<String> userCommentArray = [];
  List<String> userNameArray = [];
  List<String> userImageArray = [];
  late String videoId;
  final translator = GoogleTranslator();
// curl \
//   'https://youtube.googleapis.com/youtube/v3/commentThreads?part=snippet%2Creplies&videoId=Uv7cIJAymSs&maxResults=50&key=[YOUR_API_KEY]' \
//   --header 'Accept: application/json' \
//   --compressed

  Future<Null> CallApi(String ChannelId) async {
    setState(() {
      isloading = true;
    });
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    final Uri uri = Uri.parse(
        'https://youtube.googleapis.com/youtube/v3/commentThreads?part=snippet%2Creplies&videoId=${ChannelId}&maxResults=20&key=${API_KEY}');
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Got response');
        print(data);

        final totalItem = data['items'].length;
        print('total length is ');
        print(totalItem);
        if (totalItem > 0) {
          var i = 0;
          for (i = 0; i < totalItem; i++) {
            final userComments = data['items'][i]['snippet']['topLevelComment']
                    ['snippet']['textDisplay']
                .toString();
            final userImage = data['items'][i]['snippet']['topLevelComment']
                    ['snippet']['authorProfileImageUrl']
                .toString();

            final userName = data['items'][i]['snippet']['topLevelComment']
                    ['snippet']['authorDisplayName']
                .toString();

            var crctData = HtmlUnescape().convert(userComments);
            istranslate
                ? translatedcomment =
                    await translator.translate(crctData.toString(), to: 'en')
                : translatedcomment = '';
            istranslate
                ? userCommentArray.add(translatedcomment.toString())
                : userCommentArray.add(crctData);

            userImageArray.add(userImage);
            userNameArray.add(userName);
          }
          setState(() {
            isloading = false;
            isReached = true;
          });
          print('filtered 1st 5 comments');
          print(userCommentArray.take(5).toList());
        }
      } else {
        return throw ('nothing got');
      }
    } catch (err) {
      print(err);
      throw err;
    }
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollcontroller = ScrollController();
    const elevation = 3.0;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Comment Classifer',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.red),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  if (istranslate) {
                    setState(() {
                      istranslate = false;
                    });
                  } else {
                    setState(() {
                      istranslate = true;
                    });
                  }
                },
                tooltip: 'Translate',
                icon: Icon(
                  Icons.translate,
                  color: istranslate ? redcolor : Colors.white,
                ))
          ],
        ),
        body: Center(
          child: Column(
            children: [
              // isReached
              //     ? Card(
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Container(
              //               padding: EdgeInsets.all(8),
              //               height: 200,
              //               child: Image(
              //                 image: NetworkImage(
              //                   YoutubePlayer.getThumbnail(videoId: videoId)
              //                       .toString(),
              //                   scale: 1,
              //                 ),
              //                 fit: BoxFit.cover,
              //               ),
              //             ),
              //             Container(
              //               child: Text(_controller.metadata.title.toString(),
              //                   style: const TextStyle(
              //                       color: Colors.white,
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.w200)),
              //             )
              //           ],
              //         ),
              //       ):
              Container(
                height: 200,
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(100),
                        bottomLeft: Radius.circular(100)),
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
                      'Search Here ,',
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
                      'Find Whether your words are harmful',
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
                            controller: _searchController,
                            cursorColor: Colors.black,
                            decoration: const InputDecoration(
                              filled: true,
                              focusColor: Colors.green,
                              hoverColor: Colors.black,
                              hintText: 'i.e Enter a sentence',
                              contentPadding: EdgeInsets.all(8),
                              fillColor: Colors.red,
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                              // border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: OutlineInputBorder),
                            ),
                            onSubmitted: (val) {
                              print('the textfeild value is ${val}');

                              videoId =
                                  YoutubePlayer.convertUrlToId(val).toString();

                              // _controller = YoutubePlayerController(
                              //     initialVideoId:
                              //         YoutubePlayer.convertUrlToId(val)
                              //             .toString());
                              // print('Imageurl');
                              // print(
                              //     _controller.metadata.title.toString());
                              // print('title');
                              // print(_controller.metadata.title);
                              CallApi(videoId.toString());
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
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              'Total Comments :',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  userNameArray = [];
                                  userCommentArray = [];
                                  userImageArray = [];
                                  isloading = false;
                                  isReached = false;
                                  _searchController.clear();
//_controller.dispose();
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
                                        builder: (context) =>
                                            CommentsClassifierScreen(
                                              userCommentArray:
                                                  userCommentArray,
                                              // userCommentArray: userCommentArray
                                              //     .take(5)
                                              //     .toList(),
                                              userImageArray: userImageArray,
                                              userNameArray: userNameArray,
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
                            ),
                          ],
                        )
                      : Container(
                          padding: const EdgeInsets.all(12),
                          child: const Text(
                            'Enter a videoId',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          )),
              isReached
                  ? Expanded(
                      child: ListView.builder(
                      controller: _scrollcontroller,
                      itemCount: userNameArray.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            child: Image.network(userImageArray[index]),
                            backgroundColor: Colors.white,
                          ),
                          title: Text(
                            userNameArray[index],
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                          subtitle: Text(
                            userCommentArray[index],
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                        );
                      },
                    ))
                  : isloading
                      ? Container(
                          child: const Text(
                          'Fetching Comments',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ))
                      : Container()
            ],
          ),
        ));
  }
}

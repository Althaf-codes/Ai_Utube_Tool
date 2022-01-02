import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:client/controller/HttpController.dart';
import 'package:client/screens/constants.dart';
import 'package:client/service/JsonGetService.dart';
import 'package:client/service/SingleSentResult.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';

class ToxicityText extends StatefulWidget {
  const ToxicityText({Key? key}) : super(key: key);

  @override
  State<ToxicityText> createState() => _ToxicityTextState();
}

class _ToxicityTextState extends State<ToxicityText> {
  bool isloading = false;
  bool isReached = false;
  bool istranslate = false;
  ScrollController scrollController = ScrollController();
  var isToxic;
  List<String> labels = [];
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<SingleSentResult> _result = [];

    Future<Null> SingleFetch(String sentence) async {
      setState(() {
        isloading = true;
      });
      final Uri url = Uri.parse('http://localhost:8080/api/${sentence}');

      try {
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          print(data);
          // var isToxic = data[0][""];
          // var firstdata = data[0]["result"];

          // print(firstdata);
          if (data.length > 0) {
            int i;
            for (i = 0; i < data.length; i++) {
              var label = data[i]['label'];
              isToxic = data[data.length - 1]['result'].toString();
              print('toxic is');
              print(isToxic);
              print('label is:');
              print(label);
              labels.add(label);
              print(labels);
            }
          } else {
            setState(() {
              isToxic = 'false';
            });
          }

          setState(() {
            // isToxic = data[6]["result"];
            //   print(isToxic);
            isReached = true;
            isloading = false;
          });
        } else {
          return throw ('nothing got');
        }
      } catch (err) {
        throw (err);
      }
    }

    // @override
    // void initState() {
    //   // TODO: implement initState
    //   super.initState();
    //   setState(() {
    //      false;
    //   });
    // }

    const elevation = 3.0;

    final translator = GoogleTranslator();
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Toxicity Searcher',
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
        body: Column(
          children: [
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
                            // suffixIcon: Icon(Icons.close),
                            //  suffixIconColor: Colors.white,
                            // suffix: _searchController.text.isNotEmpty
                            //     ? GestureDetector(
                            //         onTap: () {
                            //           setState(() {
                            //             _searchController.clear();
                            //           });
                            //         },
                            //         child: const Icon(
                            //           Icons.close,
                            //           color: Colors.white,
                            //           size: 12,
                            //         ),
                            //       )
                            //     : GestureDetector(
                            //         onTap: () {
                            //           // setState(() {
                            //           //   _searchController.clear();
                            //           // });
                            //         },
                            //         child: const Icon(
                            //           Icons.add_task_rounded,
                            //           color: Colors.white,
                            //           size: 15,
                            //         ),
                            //       ),
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: OutlineInputBorder),
                          ),
                          onSubmitted: (val) {
                            print('the textfeild value is ${val}');
                            istranslate
                                ? translator
                                    .translate(val.toString(), to: 'en')
                                    .then((value) {
                                    print('the ranslated value is :');
                                    print(value);
                                    SingleFetch(value.toString());
                                  })
                                : SingleFetch(val.toString());
                            //  _searchController.clear();
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
                : Expanded(
                    child: isReached
                        ? isToxic == 'true'
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              labels = [];
                                              isReached = false;
                                              _searchController.clear();
                                            });
                                          },
                                          child: const Text(
                                            'clear',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ))
                                    ],
                                  ),
                                  const Text(
                                    'Your sentence will hurt . It contains these toxicity :',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: ListView.builder(
                                          controller: scrollController,
                                          itemCount: labels.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                child: Text(
                                                  labels[index],
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  )
                                ],
                              )
                            : isToxic == 'null'
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  labels = [];
                                                  isReached = false;
                                                  _searchController.clear();
                                                });
                                              },
                                              child: const Text(
                                                'clear',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ))
                                        ],
                                      ),
                                      const Text(
                                        'Your sentence will hurt . It contains these toxicity :',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: ListView.builder(
                                              controller: scrollController,
                                              itemCount: labels.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Center(
                                                    child: Text(
                                                      labels[index],
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      )
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Spacer(
                                            flex: 2,
                                          ),
                                          const Text(
                                            'Your words are normal',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          const Spacer(
                                            flex: 2,
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  labels = [];
                                                  isReached = false;
                                                  _searchController.clear();
                                                });
                                              },
                                              child: const Text(
                                                'clear',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ))
                                        ],
                                      ),
                                    ],
                                  )
                        : const Text(
                            'Enter a sentence',
                            style: TextStyle(color: Colors.white),
                          ),
                  )
            // Container(
            //     child: Consumer<HttpControllers>(
            //         builder: (context, model, _) =>
            //             FutureBuilder<CommentSearcher>(
            //                 future: model.fetchData(_searchController.text),
            //                 builder: (context, AsyncSnapshot snapshot) {
            //                   final _searchresult = snapshot.data;
            //                   print('the snapshot data is ${_searchresult}');
            //                   if (snapshot.connectionState ==
            //                       ConnectionState.waiting) {
            //                     return const Center(
            //                       child: CircularProgressIndicator(),
            //                     );
            //                   } else if (snapshot.data == null) {
            //                     return const Center(
            //                       child: Text('No data found'),
            //                     );
            //                   } else {
            //                     return const Padding(
            //                       padding: EdgeInsets.only(top: 20),
            //                       child: Center(
            //                         child: Text(
            //                             'Your sentence is normal and does not contain any toxicity',
            //                             style: TextStyle(
            //                               color: Colors.white,
            //                               fontSize: 16,
            //                               fontWeight: FontWeight.w600,
            //                             )),
            //                       ),
            //                     );
            //                   }
            //                 }))),
          ],
        ));
  }
}

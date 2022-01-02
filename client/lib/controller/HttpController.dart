import 'dart:convert';

import 'package:client/service/SingleSentResult.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpControllers extends ChangeNotifier {
  Future<SingleSentResult> SingleFetch(String sentence) async {
    final Uri url = Uri.parse('http://localhost:8080/api/${sentence}');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);

        final SingleSentResult result = SingleSentResult.fromJson(data);
        return result;
      } else {
        return throw ('nothing got');
      }
    } catch (err) {
      throw (err);
    }
  }
}


  // Future<CommentSearcher> fetchData(String sentence) async {
  //   final Uri url = Uri.parse('http://localhost:8080/prediction/${sentence}');
  //   try {
  //     final response = await http.get(url);
  //     if (200 == response.statusCode) {
  //       final commentSearcher =
  //           commentSearcherFromJson(jsonDecode(response.body));
  //       return commentSearcher;
  //     } else {
  //       return throw ('nothing got');
  //     }
  //   } catch (err) {
  //     print('error was ${err}');
  //     throw (err);
  //   }
  // }


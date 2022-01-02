// To parse this JSON data, do
//
//     final singleSentResult = singleSentResultFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

List<SingleSentResult> singleSentResultFromJson(String str) =>
    List<SingleSentResult>.from(
        json.decode(str).map((x) => SingleSentResult.fromJson(x)));

String singleSentResultToJson(List<SingleSentResult> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SingleSentResult {
  SingleSentResult({
    required this.label,
    required this.result,
  });

  String label;
  bool result;

  factory SingleSentResult.fromJson(Map<String, dynamic> json) =>
      SingleSentResult(
        label: json["label"],
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "result": result,
      };
}

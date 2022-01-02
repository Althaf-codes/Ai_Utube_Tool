// To parse this JSON data, do
//
//     final commentSearcher = commentSearcherFromJson(jsonString);

import 'dart:convert';

CommentSearcher commentSearcherFromJson(String str) =>
    CommentSearcher.fromJson(json.decode(str));

String commentSearcherToJson(CommentSearcher data) =>
    json.encode(data.toJson());

class CommentSearcher {
  CommentSearcher({
    required this.finalresult,
  });

  List<Finalresult> finalresult;

  factory CommentSearcher.fromJson(Map<String, dynamic> json) =>
      CommentSearcher(
        finalresult: List<Finalresult>.from(
            json["finalresult"].map((x) => Finalresult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "finalresult": List<dynamic>.from(finalresult.map((x) => x.toJson())),
      };
}

class Finalresult {
  Finalresult({
    required this.label,
    required this.result,
  });

  String label;
  bool result;

  factory Finalresult.fromJson(Map<String, dynamic> json) => Finalresult(
        label: json["label"],
        result: json["result"] == null ? json["result"] : json["result"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "result": result == null ? result : result,
      };
}

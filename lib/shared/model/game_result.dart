import 'dart:convert';

class GameResult {
  final String type;
  final String date;
  final int totalQuestions;
  final int rightAnswers;

  GameResult(
      {required this.type,
      required this.date,
      required this.totalQuestions,
      required this.rightAnswers});

  static List<GameResult> convertJsonToList(List<String> jsonList) {
    return jsonList.map((jsonString) {
      return GameResult.fromJson(jsonString);
    }).toList();
  }

  static List<String> convertListToJson(List<GameResult> gameList) {
    return gameList.map((game) {
      return game.toJson();
    }).toList();
  }

  factory GameResult.fromMap(Map<String, dynamic> map) {
    return GameResult(
      type: map['type'] as String,
      date: map['date'] as String,
      totalQuestions: map['totalQuestions'] as int,
      rightAnswers: map['rightAnswers'] as int,
    );
  }

  factory GameResult.fromJson(String json) {
    return GameResult.fromMap(jsonDecode(json));
  }

  Map<String, dynamic> toMap() => {
        "type": type,
        "date": date,
        "totalQuestions": totalQuestions,
        "rightAnswers": rightAnswers,
      };

  String toJson() => jsonEncode(toMap());
}

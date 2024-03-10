import 'package:fono_terapia/shared/model/sub_category.dart';

class GameResult {
  int? id;
  final String date;
  final int totalQuestions;
  final int answeredCorrectly;
  final SubCategory subCategory;

  GameResult(
    this.id,
    this.date,
    this.totalQuestions,
    this.answeredCorrectly,
    this.subCategory,
  );

  @override
  String toString() {
    return 'GameResult{id: $id, date: $date, totalQuestions: $totalQuestions, answeredCorrectly: $answeredCorrectly, subCategory: $subCategory}';
  }
}

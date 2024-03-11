import 'package:fono_terapia/shared/model/category.dart';
import 'package:fono_terapia/shared/model/sub_category.dart';

class GameResult {
  int? id;
  final String date;
  final int totalQuestions;
  final int answeredCorrectly;
  final SubCategory subCategory;
  final Category category;

  GameResult(this.id, this.date, this.totalQuestions, this.answeredCorrectly,
      this.subCategory, this.category);

  @override
  String toString() {
    return 'GameResult{id: $id, date: $date, totalQuestions: $totalQuestions, answeredCorrectly: $answeredCorrectly, subCategory: $subCategory, category: $category}';
  }
}

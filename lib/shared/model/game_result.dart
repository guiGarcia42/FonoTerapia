class GameResult {
  final int id;
  final String subCategory;
  final String date;
  final int totalQuestions;
  final int rightAnswers;

  GameResult(
      {required this.id,
      required this.subCategory,
      required this.date,
      required this.totalQuestions,
      required this.rightAnswers});
}

class Question {
  final int id;
  final String question;
  final List<String> options;
  final String answer;
  String userAnswer = '';

  Question(
      {required this.id,
      required this.question,
      required this.options,
      required this.answer,
      required this.userAnswer});
}

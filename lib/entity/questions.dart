class Question {
  final int id;
  final String question;
  final List<String> options;
  String answer;

  Question(
      {required this.id,
      required this.question,
      required this.options,
      required this.answer});
}

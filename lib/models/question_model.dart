enum QuestionType { mcq, fillup, qna }

class Question {
  final QuestionType type;
  final String question;
  final List<String>? options; // 4 options for MCQ
  final int? correctIndex; // index in options for MCQ
  final String answer; // full answer text
  final String hint; // clue to help find the answer
  final String explanation; // detailed explanation after answer

  const Question({
    required this.type,
    required this.question,
    this.options,
    this.correctIndex,
    required this.answer,
    required this.hint,
    required this.explanation,
  });
}

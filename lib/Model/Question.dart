class Question{
  final String question;
  final List<Answer> answers;

  Question({
    this.question,
    this.answers
});
}

class Answer {
  final bool correct;
  final String text;

  Answer({
    this.correct,
    this.text
  });
}
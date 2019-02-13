import 'package:examen_flutter/Model/Question.dart';

abstract class ListScreenView {
  openQuestionScreen(int position);

  showQuestions(List<Question> questions);

  showLoading();

  hideLoading();

  showError();
}
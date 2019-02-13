import 'package:examen_flutter/Model/Question.dart';
import 'package:http/http.dart' as network;
import 'dart:convert';
import 'package:examen_flutter/ListScreen/ListScreen.dart';
import 'package:examen_flutter/ListScreen/ListScreenView.dart';
import 'dart:math';

class ListScreenPresenter {
  ListScreenView _view;

  ListScreenPresenter(this._view);

  fetchData() async {
    _view.showLoading();
    network.Response response =
    await network.get('https://opentdb.com/api.php?amount=10');
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      List<Question> questions = jsonBody['results'].map<Question>((element) {
        String question = element['question'];
        Answer correct = new Answer(correct: true, text: element['correct_answer']);
        List<Answer> answers = new List();
        for(String x in element['incorrect_answers']){
          answers.add(new Answer(correct: false, text: x));
        }
        answers.add(correct);
        return Question(question: question, answers: shuffle(answers));
      }).toList();
      _view.showQuestions(questions);
    } else {
      _view.showError();
    }
    _view.hideLoading();
  }

  elementClicked(int position) {
    _view.openQuestionScreen(position);
  }

  List shuffle(List items) {
    var random = new Random();

    // Go through all elements.
    for (var i = items.length - 1; i > 0; i--) {

      // Pick a pseudorandom number according to the list length
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }

}
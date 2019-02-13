import 'package:examen_flutter/Model/Question.dart';
import 'package:examen_flutter/QuestionScreen/QuestionScreen.dart';
import 'package:examen_flutter/QuestionScreen/QuestionScreenView.dart';
import 'package:flutter/material.dart';

class QuestionScreenPresenter {
  QuestionScreenView _view;

  QuestionScreenPresenter(this._view);

  Widget getWidgets(Question question) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < question.answers.length; i++) {
      list.add(RaisedButton(
          child: new Text(question.answers[i].text),
          onPressed: (){_view.onTappedAnswer(i);}));
    }
    return new Column(children: list);
  }
}

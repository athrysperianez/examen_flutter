import 'package:examen_flutter/ListScreen/ListScreen.dart';
import 'package:examen_flutter/Model/Question.dart';
import 'package:examen_flutter/QuestionScreen/QuestionScreenPresenter.dart';
import 'package:examen_flutter/QuestionScreen/QuestionScreenView.dart';
import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  final Question question;

  QuestionScreen(this.question);

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen>
    implements QuestionScreenView {
  QuestionScreenPresenter _questionScreenPresenter;

  _QuestionScreenState() {
    _questionScreenPresenter = QuestionScreenPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pregunta"),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            Container(
                child: new Text(widget.question.question),
                margin: const EdgeInsets.all(10.0)),
            _questionScreenPresenter.getWidgets(widget.question)
          ],
        )));
  }

  @override
  onTappedAnswer(int i) {
    if (widget.question.answers[i].correct) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Correcta"),
              actions: <Widget>[
                new RaisedButton(
                  child: const Text('Aceptar',
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                        builder: (context) => ListScreen()
                    ),
                    ModalRoute.withName("/Home")
                    );},
                )
              ],
            );
          });
    } else {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Incorrecta"),
              actions: <Widget>[
                new RaisedButton(
                  child: const Text(
                    'Aceptar',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }
}

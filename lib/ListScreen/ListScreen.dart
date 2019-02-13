import 'package:examen_flutter/QuestionScreen/QuestionScreen.dart';
import 'package:flutter/material.dart';
import 'ListScreenPresenter.dart';
import 'ListScreenView.dart';
import 'ListScreenPresenter.dart';
import 'package:examen_flutter/Model/Question.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> implements ListScreenView {
  ListScreenPresenter _homePresenter;
  List<Question> _questions = [];
  bool _isLoading = true;
  bool _isError = false;

  _ListScreenState() {
    _homePresenter = ListScreenPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _homePresenter.fetchData();
  }

  @override
  openQuestionScreen(int position) {
    Navigator.push(context, MaterialPageRoute(builder: (c) {
      return QuestionScreen(_questions[position]);
    }));
  }

  @override
  showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  @override
  hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  showError() {
    setState(() {
      _isError = true;
    });
  }

  @override
  showQuestions(List<Question> questions) {
    setState(() {
      this._questions = questions;
    });
  }

  buildBody() {
    if (_isLoading) {
      return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 90.0),
            child: CircularProgressIndicator(),
          ));
    }
    else if (_isError) {
      return Center(child: Text("Ha habido un error"));
    } else {
      return RefreshIndicator(
        onRefresh: () {
          _homePresenter.fetchData();
        },
        child: ListView.builder(
          itemBuilder: (context, position) {
            return ListTile(
              leading: Icon(Icons.question_answer),
              title:
              Text(_questions[position].question),
              onTap: () {
                _homePresenter.elementClicked(position);
              },
            );
          },
          itemCount: _questions.length,
          reverse: false,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter examen"),
      ),
      body: buildBody(),
    );
  }
}
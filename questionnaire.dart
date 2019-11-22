import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/api.dart';
import 'package:my_first_flutter_app/models/question.dart';
import 'package:my_first_flutter_app/question_adapter.dart';

import 'models/answer.dart';

class Questionnaire extends StatefulWidget {
  List<Question> questions;
  int userId;

  Questionnaire({this.questions, this.userId});

  @override
  _Questionnaire createState() => _Questionnaire(questions: questions);
}

class _Questionnaire extends State<Questionnaire> {
  List<Question> questions;

  _Questionnaire({this.questions});

  updateAnswer(Question question, int answer) {
    setState(() {
      question.answer = answer;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Answer Questions"),
        centerTitle: true,
      ),
      body: Column(children: [
        Container(
            margin: EdgeInsets.all(20.0),
            child: Text(
                "Answer the following questions on a scale from -5 to 5",
                style: TextStyle(fontSize: 20))),
        Expanded(
            child: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: this.questions.length,
          itemBuilder: (context, index) {
            return QuestionAdapter(
                question: questions[index], updateAnswer: updateAnswer);
          },
        ))
      ]),
      floatingActionButton: FloatingActionButton(
        child: Text('Send'),
        onPressed: () {
          List<Answer> answers = new List<Answer>();
          Api.getLocation().then((currentLocation) {
            var currentTime = new DateTime.now();
            for (Question q in questions) {
              Answer answer = Answer(
                  latitude: currentLocation.latitude,
                  longitude: currentLocation.longitude,
                  date: currentTime,
                  answer: q.answer,
                  questionId: q.id,
                  userId: widget.userId);
              answers.add(answer);
            }
            print(answers);
            Api.sendAnswers(answers).then((response) {
              if (response.statusCode == 200) {
                _showMaterialDialog("Success!", "Your Answers were sent to the server!");
              }else{
                _showMaterialDialog("Fail!", "There was an error on the way, please send your answeres again!");
              }
            });
          });
        },
      ),
    );
  }
  void _showMaterialDialog(String title,String text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('${title}'),
            content: Text('${text}'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    _dismissDialog();
                  },
                  child: Text('Ok')),
            ],
          );
        });
  }
  _dismissDialog() {
    Navigator.pop(context);
  }
}


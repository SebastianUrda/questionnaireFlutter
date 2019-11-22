import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/api.dart';
import 'package:my_first_flutter_app/models/question.dart';
import 'package:my_first_flutter_app/questionnaire.dart';

class QuestionnairePicker extends StatelessWidget {
  String name;
  int userId;

  QuestionnairePicker({this.name, this.userId});

  Future<List<Question>> getQuestions(String type) async {
    var response = await Api.getQuestions(type);
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      List iterator = jsonDecode(response.body);
      List<Question> questions =
          iterator.map((model) => Question.fromJson(model)).toList();
      return questions;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        appBar: AppBar(
          title: Text('Hello, ${name}'),
        ),
        body: Center(
            child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
//              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Please select the questionnaire type you want to answer!",
                    style: TextStyle(fontSize: 20)),
                SizedBox(height: 20.0),
                Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Color(0xff01A0C7),
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      onPressed: () {
                        getQuestions('temperature').then((questions) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Questionnaire(
                                      questions: questions, userId: userId)));
                        });
                      },
                      child: Text("Temperature",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    )),
                SizedBox(
                  height: 10.0,
                ),
                Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Color(0xff01A0C7),
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      onPressed: () {
                        getQuestions('dust').then((questions) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Questionnaire(
                                      questions: questions, userId: userId)));
                        });
                      },
                      child: Text("Dust",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    )),
                SizedBox(
                  height: 10.0,
                ),
                Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Color(0xff01A0C7),
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      onPressed: () {
                        getQuestions('humidity').then((questions) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Questionnaire(
                                      questions: questions, userId: userId)));
                        });
                      },
                      child: Text("Humidity",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    )),
                SizedBox(
                  height: 10.0,
                ),
                Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Color(0xff01A0C7),
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      onPressed: () {
                        getQuestions('light').then((questions) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Questionnaire(
                                      questions: questions, userId: userId)));
                        });
                      },
                      child: Text("Light",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    )),
              ]),
        ))));
  }

}

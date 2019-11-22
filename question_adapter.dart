import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/models/question.dart';

class QuestionAdapter extends StatefulWidget {
  Question question;
  final void Function(Question question, int answer) updateAnswer;
  QuestionAdapter({this.question,this.updateAnswer});

  @override
  _QuestionAdapter createState() => _QuestionAdapter(question: this.question);
}

class _QuestionAdapter extends State<QuestionAdapter> {
  Question question;
  double answer = 0;
  _QuestionAdapter({this.question});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                question.text,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 6.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width:300,
                      child: Slider(
                    value: answer,
                    min: -5,
                    max: 5,
                    divisions: 10,
                    onChanged: (double newValue) {
                      setState(() {
                        answer = newValue;
                      });
                      widget.updateAnswer(question,newValue.toInt());
                    },
                  )),
                  Text('${answer}'),
                ],
              ),
            ],
          ),
        ));
  }
}

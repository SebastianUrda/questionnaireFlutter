import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/api.dart';
import 'package:my_first_flutter_app/questionnaire_type.dart';
import 'package:my_first_flutter_app/register.dart';

import 'models/user.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  User authenticated;

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: Text("PEMS"),
        centerTitle: true,
      ),
      body: Center(
          child: Container(
              padding: EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    obscureText: false,
                    controller: usernameController,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Username",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0))),
                  ),
                  TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0))),
                  ),
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
                          User toAuthenticate = User.auth(
                              username: usernameController.text,
                              password: passwordController.text);

                          Api.authenticateUser(toAuthenticate).then((response){
                            if (response.statusCode == 200) {
                              authenticated = User.fromJson(jsonDecode(response.body));
                              if (authenticated.getId() != 0) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => QuestionnairePicker(
                                            name: authenticated.getUsername(),
                                            userId: authenticated.getId())));
                              }
                              else{
                                _showMaterialDialog("Log In failed",
                                    "Something went wrong, please try again!");
                              }
                            }
                            else{
                              _showMaterialDialog("Log In failed",
                                  "Something went wrong, please try again!");
                            }
                          });
                        },
                        child: Text("Login",
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()));
                        },
                        child: Text("Register",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      )),
                ],
              ))),
    ));
  }

  void _showMaterialDialog(String title, String text) {
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

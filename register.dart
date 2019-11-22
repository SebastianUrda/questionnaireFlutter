import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/api.dart';

import 'models/user.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool male = false;
  bool female = false;
  String username;
  String password;
  String confirmPassword;
  String email;
  String birthday;
  @override
  Widget build(BuildContext context) {

    return (Scaffold(
      appBar: AppBar(
        title: Text("PEMS"),
        centerTitle: true,
      ),
      body: Center(
          child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    obscureText: false,
                    onChanged: (text) => setState(() {
                      username=text;
                    }),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Username",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0))),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    obscureText: true,
                    onChanged: (text) => setState(() {
                      password=text;
                    }),
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
                  TextField(
                    obscureText: true,
                    onChanged: (text) => setState(() {
                      confirmPassword=text;
                    }),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Confirm password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0))),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    obscureText: false,
                    onChanged: (text) => setState(() {
                      email=text;
                    }),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0))),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Text("Male"),
                          Checkbox(
                            value: male,
                            onChanged: (bool val) => setState(() {
                              male = val;
                              female = !val;
                            }),
                          ),
                          Text("Female"),
                          Checkbox(
                            value: female,
                            onChanged: (bool val) => setState(() {
                              female = val;
                              male = !val;
                            }),
                          )
                        ],
                      )),
                  TextField(
                    obscureText: false,
                    onChanged: (text) => setState(() {
                      birthday=text;
                    }),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Birthday YYYY-MM-DD",
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
                          if (!(password ==confirmPassword)) {
                            _showMaterialDialog(
                                "Fail", "Passwords do not match");
                          }
                          RegExp dateRegEx = new RegExp(
                              r"^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$");
                          if (!dateRegEx.hasMatch(birthday)) {
                            _showMaterialDialog("Fail", "Wrong Date format");
                          }
                          String sex = male ? "male" : "female";

                          User toRegister = User.register(
                              username: username,
                              password: password,
                              email: email,
                              sex: sex,
                              birthday: birthday+"T00:00:00Z");
                          Api.registerUser(toRegister).then((response){
                            if(response.statusCode==200){
                              _showMaterialDialog("Success!", "User Registered Sucessfully!");
                            }else{
                              _showMaterialDialog("Fail!", "Please try again! ${response.body}");
                            }
                          });
                        },
                        child: Text("Register",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      )),
//                  SizedBox(
//                    height: 10.0,
//                  ),
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

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/user.dart';

import 'package:location/location.dart';
import 'models/answer.dart';
class Api {
  static Future<http.Response> authenticateUser(User auth) async {
    var url = 'http://licenta.ddns.net:8080/mightWork/user';
    var response = await http.post(url, body: jsonEncode(auth));
    return response;
  }
  static Future<http.Response> registerUser(User register)async{
    var url = 'http://licenta.ddns.net:8080/mightWork/register';
    var response = await http.post(url, body: jsonEncode(register));
    return response;
  }

  static Future getQuestions(String type) async {
    var url = 'http://licenta.ddns.net:8080/mightWork/question?type=' + type;
    var response = await http.get(url);
    return response;
  }

  static Future sendAnswers(List<Answer> answers) async{
    var toSend=jsonEncode(answers.map((a)=>a.toJson()).toList());
    print(toSend);
    var url = 'http://licenta.ddns.net:8080/mightWork/answers';
    var response = await http.post(url, body: toSend);
    return response;
  }
  static Future getLocation() async{
    var location = new Location();
    var currentLocation = await location.getLocation();
    return currentLocation;
  }
}

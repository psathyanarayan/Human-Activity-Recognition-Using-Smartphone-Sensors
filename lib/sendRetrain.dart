import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'admin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReTrain {
  sendRetrainApi(var data) async {
    var body = json.encode(data);
    print(body);
    // df.add(body);
    // print("hi");
    // print(body);
    // var response = await http.post(
    //   Uri.parse("https://sensorapi.up.railway.app/predict"),
    //   headers: {"Content-Type": "application/json"},
    //   body: body,
    // );
    // // print('Response status: ${response.statusCode}');
    // // print('Response body: ${response.body}');
    // var result = response.body;
    // var jsonData = json.decode(result);
    // var bodyData = jsonData['prediction'];
    // // print(bodyData);
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString('bodyData', bodyData);
    // print('Habibi');
    // print(prefs.getString('bodyData'));
    // return Future.delayed(Duration(seconds: 2), () => bodyData);
  }
}

// void main() {
//   final data = {
//     "ax": 0.0005476746009662747,
//     "ay": 0.0034132003784179688,
//     "az": -0.0004718303680419922,
//     "gx": 0.0,
//     "gy": 0.0034132003784179688,
//     "gz": 0.0
//   };
//   var ReTrain = ReTrain();

//   ReTrain.sendRetrainApi(data);
// }

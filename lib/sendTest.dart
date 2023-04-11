import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiReq {
  sendApi(var data) async {
    final body = json.encode(data);
    // print("hi");
    print(body);
    var response = await http.post(
      Uri.parse("http://10.0.2.2:5000/predict"),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    final result = response.body;
    var jsonData = json.decode(result);
    print(jsonData['prediction']);
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
//   var apiReq = ApiReq();
  
//     apiReq.sendApi(data);

// }

//import 'dart:async';

import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sensor_data_logging/jsonConv.dart';
import 'package:sensor_data_logging/login.dart';
import 'package:sensor_data_logging/sendTest.dart';
import 'package:shared_preferences/shared_preferences.dart';
// void main() {
//   runApp(const admin());
// }

class admin extends StatelessWidget {
  const admin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sensors Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyAdminPage(title: 'Activity'),
    );
  }
}

var apiReq = ApiReq();
// print(acc);

// print(finalData);
class MyAdminPage extends StatefulWidget {
  const MyAdminPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<MyAdminPage> createState() => _MyAdminPageState();
}

class _MyAdminPageState extends State<MyAdminPage> {
  late StreamController<String> bodyDataController;
  late Stream<String> bodyDataStream;
  late StreamSubscription<String> bodyDataStreamSubscription;

  @override
  void initState() {
    super.initState();
    bodyDataController = StreamController<String>();
    bodyDataStream = getBodyDataStream();
    bodyDataStreamSubscription = bodyDataStream.listen((data) {
      bodyDataController.add(data);
    });
  }

  @override
  void dispose() {
    bodyDataController.close();
    bodyDataStreamSubscription.cancel();
    super.dispose();
  }

  Stream<String> getBodyDataStream() async* {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  while (true) {
    try {
      // Send an HTTP GET request to the API endpoint
      var response = await http.get(Uri.parse('https://sensorapi.up.railway.app/predict'));

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Parse the response body as a JSON array
        var bodyData = response.body;
          if (bodyData != null) {
            yield bodyData;
          }
        }
      else {
        // If the response is not successful, log the error and wait for a bit before trying again
        print('Error: HTTP ${response.statusCode}');
        await Future.delayed(Duration(milliseconds: 500));
      }
    } catch (e) {
      // If there's an exception, log the error and wait for a bit before trying again
      print('Error: $e');
      await Future.delayed(Duration(milliseconds: 500));
    }
  }
}

  @override
  Widget build(BuildContext context) {
    // final accelerometer =
    // _accelerometerValues?.map((double v) => v.toStringAsFixed(1)).toList();
    // final gyroscope =
    // _gyroscopeValues?.map((double v) => v.toStringAsFixed(1)).toList();
    // final userAccelerometer = _userAccelerometerValues
    //     ?.map((double v) => v.toStringAsFixed(1))
    //     .toList();
    // final magnetometer =
    // _magnetometerValues?.map((double v) => v.toStringAsFixed(1)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: Icon(
                  Icons.logout,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.black38),
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.blue[500],
            radius: 45,
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"), //NetworkImage
              radius: 100,
            ), //CircleAvatar
          ),
          Text(
            "Name : Admin",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "Role : Admin",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "Organisation : abc",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          Card(
            elevation: 10,
            shadowColor: Colors.black,
            color: Colors.blue[100],
            child: SizedBox(
              width: 300,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 26,
                    ), //SizedBox
                    Text(
                      'Activity Report',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.blue[900],
                        fontWeight: FontWeight.w400,
                      ), //Textstyle
                    ), //Text
                    const SizedBox(
                      height: 26,
                    ), //SizedBox
                    Center(
      child: StreamBuilder<String>(
        stream: bodyDataController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(
              "Error: ${snapshot.error}",
              style: TextStyle(
                fontSize: 20,
                color: Colors.red,
                fontWeight: FontWeight.w400,
              ),
            );
          } else if (!snapshot.hasData) {
            return Text(
              "Loading...",
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue[500],
                fontWeight: FontWeight.w400,
              ),
            );
          }
          return Text(
            snapshot.data!,
            style: TextStyle(
              fontSize: 20,
              color: Colors.blue[500],
              fontWeight: FontWeight.w400,
            ),
          );
        },
      ),
    )
                  ],
                ), //Column
              ), //Padding
            ), //SizedBox
          ), //Card
        ],
      ),
    );
  }
}

import 'dart:async';
import 'admin.dart';
import 'package:flutter/material.dart';
// import 'package:sensor_data_logging/chart.dart';
import 'package:sensor_data_logging/gyroscope_data.dart';
import 'package:sensor_data_logging/login.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'jsonConv.dart';
import 'sendTest.dart';
import 'accelerometer_data.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<double>? _accelerometerValues;
  List<double>? _userAccelerometerValues;
  List<double>? _gyroscopeValues;
  List<double>? _magnetometerValues;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  List<AccelerometerData> _accelerometerData = [];
  List<GyroscopeData> _gyroscopeData = [];

  int backAndForth = 0;

  @override
  Widget build(BuildContext context) {
    final accelerometer =
        _accelerometerValues?.map((double v) => v.toStringAsFixed(1)).toList();
    final gyroscope =
        _gyroscopeValues?.map((double v) => v.toStringAsFixed(1)).toList();
    final userAccelerometer = _userAccelerometerValues
        ?.map((double v) => v.toStringAsFixed(1))
        .toList();
    final magnetometer =
        _magnetometerValues?.map((double v) => v.toStringAsFixed(1)).toList();

    SensorData acc = SensorData(
      Ax: _accelerometerValues![0],
      Ay: _accelerometerValues![1],
      Az: _accelerometerValues![2],
      LAx: _userAccelerometerValues![0],
      LAy: _userAccelerometerValues![1],
      LAz: _userAccelerometerValues![2],
      Gx: _gyroscopeValues![0],
      Gy: _gyroscopeValues![1],
      Gz: _gyroscopeValues![2],
      Mx: _magnetometerValues![0],
      My: _magnetometerValues![1],
      Mz: _magnetometerValues![2],
    );
    // print(acc);

    var apiReq = ApiReq();
    // print(acc);
    var finalData = apiReq.sendApi(acc);
    // print(finalData);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Recognition'),
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
                    CircleAvatar(
                      backgroundColor: Colors.blue[500],
                      radius: 45,
                      child: const CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"), //NetworkImage
                        radius: 100,
                      ), //CircleAvatar
                    ), //CircleAvatar
                    const SizedBox(
                      height: 10,
                    ), //SizedBox
                    Text(
                      'Person 1',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.blue[900],
                        fontWeight: FontWeight.w500,
                      ), //Textstyle
                    ), //Text
                    const SizedBox(
                      height: 10,
                    ), //SizedBox

                    // RaisedButton is deprecated and should not be used
                    // Use ElevatedButton instead

                    // child: RaisedButton(
                    //   onPressed: () => null,
                    //   color: Colors.green,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(4.0),
                    //     child: Row(
                    //       children: const [
                    //         Icon(Icons.touch_app),
                    //         Text('Visit'),
                    //       ],
                    //     ), //Row
                    //   ), //Padding
                    // ), //RaisedButton
                    //SizedBox
                  ],
                ), //Column
              ), //Padding
            ), //SizedBox
          ), //Card
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: <Widget>[
          //       Text('Accelerometer: $accelerometer'),
          //     ],
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: <Widget>[
          //       Text('UserAccelerometer: $userAccelerometer'),

          //     ],
          //   ),
          // ),
          Text('Gyroscope: $gyroscope',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          Text('Accelerometer: $userAccelerometer',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          SizedBox(
            width: 350,
            height: 50,
            child: ElevatedButton(
              child: const Text("Start"),
              onPressed: () {
                if (backAndForth % 2 == 1) {
                  _accelerometerData.clear();
                  _gyroscopeData.clear();
                }
                // start a stream that saves acceleroemeterData
                _streamSubscriptions
                    .add(accelerometerEvents.listen((AccelerometerEvent event) {
                  _accelerometerData.add(AccelerometerData(
                      DateTime.now(), <double>[event.x, event.y, event.z]));
                }));
                // start a stream that saves gyroscopeData
                _streamSubscriptions
                    .add(gyroscopeEvents.listen((GyroscopeEvent event) {
                  _gyroscopeData.add(GyroscopeData(
                      DateTime.now(), <double>[event.x, event.y, event.z]));
                }));
                backAndForth++;
              },
            ),
          ),
          SizedBox(
            width: 350,
            height: 50,
            child: ElevatedButton(
              child: const Text("Stop"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                // print("length: ${_accelerometerData.length}");
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => admin(
                //           accelerometerData: _accelerometerData,
                //           gyroscopeData: _gyroscopeData)),
                // );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(
      accelerometerEvents.listen(
        (AccelerometerEvent event) {
          setState(() {
            _accelerometerValues = <double>[event.x, event.y, event.z];
          });
        },
      ),
    );
    _streamSubscriptions.add(
      gyroscopeEvents.listen(
        (GyroscopeEvent event) {
          setState(() {
            _gyroscopeValues = <double>[event.x, event.y, event.z];
          });
        },
      ),
    );
    _streamSubscriptions.add(
      userAccelerometerEvents.listen(
        (UserAccelerometerEvent event) {
          setState(() {
            _userAccelerometerValues = <double>[event.x, event.y, event.z];
          });
        },
      ),
    );
    _streamSubscriptions.add(
      magnetometerEvents.listen(
        (MagnetometerEvent event) {
          setState(() {
            _magnetometerValues = <double>[event.x, event.y, event.z];
          });
        },
      ),
    );
  }
}

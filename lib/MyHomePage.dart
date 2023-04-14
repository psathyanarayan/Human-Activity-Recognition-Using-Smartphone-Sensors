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
import 'package:firebase_auth/firebase_auth.dart';

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
      // appBar: AppBar(
      //   title: const Text('Activity Recognition'),
      //   actions: <Widget>[
      //     Padding(
      //         padding: EdgeInsets.only(right: 20.0),
      //         child: GestureDetector(
      //           onTap: () {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(builder: (context) => Login()),
      //             );
      //           },
      //           child: Icon(
      //             Icons.logout,
      //             size: 26.0,
      //           ),
      //         )),
      //   ],
      // ),
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
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: SizedBox(
                width: 300,
                height: 440,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const CircleAvatar(
                      radius: 45,
                      backgroundImage: NetworkImage(
                        'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541',
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Person 1',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('Sensor')),
                            DataColumn(label: Text('Value')),
                          ],
                          rows: [
                            DataRow(
                              cells: [
                                const DataCell(Text('Gyroscope')),
                                DataCell(Text('$gyroscope')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                const DataCell(Text('Accelerometer')),
                                DataCell(Text('$accelerometer')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                const DataCell(Text('Linear Acceleration')),
                                DataCell(Text('$userAccelerometer')),
                              ],
                            ),
                            DataRow(
                              cells: [
                                const DataCell(Text('Magnetometer')),
                                DataCell(Text('$magnetometer')),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text(
                  'Log Out',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                    // super.dispose();
                     dispose();

    // Navigate to the Login page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    ); // navigate to the login screen
                  } catch (e) {
                    // Handle logout failure
                  }
                }),
          ]),
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

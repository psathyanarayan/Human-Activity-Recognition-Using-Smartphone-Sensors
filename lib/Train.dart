import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensor_data_logging/jsonConvRetrain.dart';
import 'package:sensor_data_logging/sendRetrain.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'jsonConv.dart';
import 'sendTest.dart';

class Train extends StatefulWidget {
  const Train({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<Train> createState() => _TrainState();
}

class _TrainState extends State<Train> {
  List<double>? _accelerometerValues;
  List<double>? _userAccelerometerValues;
  List<double>? _gyroscopeValues;
  List<double>? _magnetometerValues;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  TextEditingController nameController = TextEditingController();

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
    // This helps to prevent null point exception
    
    RetrainData? acc = _accelerometerValues != null &&
            _userAccelerometerValues != null &&
            _gyroscopeValues != null &&
            _magnetometerValues != null
        ? RetrainData(
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
            activity: nameController.text)
        : null;

    // print(finalData);

    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
          Widget>[
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
            height: 370,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 14),
                const Text(
                  'Model Training',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
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
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 255, 255, 255),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    labelText: 'Activity',
                    labelStyle: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: 'Enter your activity eg 1walking',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 18.0,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your activity eg 1walking';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 33, 243, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text(
                'Start',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                _streamSubscriptions.add(
                  accelerometerEvents.listen(
                    (AccelerometerEvent event) {
                      setState(() {
                        _accelerometerValues = <double>[
                          event.x,
                          event.y,
                          event.z
                        ];
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
                        _userAccelerometerValues = <double>[
                          event.x,
                          event.y,
                          event.z
                        ];
                      });
                    },
                  ),
                );
                _streamSubscriptions.add(
                  magnetometerEvents.listen(
                    (MagnetometerEvent event) {
                      setState(() {
                        _magnetometerValues = <double>[
                          event.x,
                          event.y,
                          event.z
                        ];
                      });
                    },
                  ),
                );
              },
            ),
            const SizedBox(width: 20), // Add some spacing between the buttons
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 243, 33, 33),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text(
                'Stop',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () async {
                for (final subscription in _streamSubscriptions) {
                  subscription.cancel();
                }
                var apiRetrainReq = ReTrain();
                // print(acc);
                Future finalData = apiRetrainReq.sendRetrainApi(acc);
                //Text(finalData);
                print(finalData);
              },
            ),
          ],
        )
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
  }
}

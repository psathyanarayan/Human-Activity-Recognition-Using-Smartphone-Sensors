import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sensor_data_logging/login.dart';
import 'package:sensor_data_logging/sendTest.dart';


// ignore: camel_case_types
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
    
    while (true) {
      try {
        // Send an HTTP GET request to the API endpoint
        var response = await http
            .get(Uri.parse('https://sensorapi.up.railway.app/predict'));

        // Check if the response is successful
        if (response.statusCode == 200) {
          // Parse the response body as a JSON array
          var bodyData = response.body;
          yield bodyData;
        } else {
          // If the response is not successful, log the error and wait for a bit before trying again
          // ignore: avoid_print
          print('Error: HTTP ${response.statusCode}');
          await Future.delayed(const Duration(milliseconds: 500));
        }
      } catch (e) {
        // If there's an exception, log the error and wait for a bit before trying again
        // ignore: avoid_print
        print('Error: $e');
        await Future.delayed(const Duration(milliseconds: 500));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    
    Set<String> snapshotDataList = <String>{};

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
                child: const Icon(
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: SizedBox(
              width: 300,
              height: 540,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 26,
                    ), //SizedBox
                    Center(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.0, color: Colors.black38),
                        ),
                      ),
                    ),
                  

                    Text(
                      'Activity Report',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.blue[900],
                        fontWeight: FontWeight.w400,
                      ), //Textstyle
                    ), 
                    //Text
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
                              style: const TextStyle(
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
                          } else {
                            String? snapshotData = snapshot.data;
                            String dataDigits =
                                snapshotData!.replaceAll(RegExp('[^0-9]'), '');
                           
                            
                            if (!snapshotDataList.contains(snapshotData)) {
                              if ((snapshotDataList
                                  .any((str) => str.contains(dataDigits)))) {
                                String existingData = snapshotDataList.firstWhere(
                                (str) => str.contains(dataDigits));
                            snapshotDataList.remove(existingData);
                            snapshotDataList.add(snapshotData);
                              } else {
                                snapshotDataList.add(snapshotData);
                              }
                            }
                            // print(snapshotDataList);
                          }

                          return SizedBox(
  height: 400, // set a fixed height for the SizedBox
  child: SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: DataTable(
      columns: const [
        DataColumn(
          label: Text(
            'Human Activity Data',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
      rows: snapshotDataList.map((data) {
        return DataRow(cells: [
          DataCell(
            SizedBox(
              width: MediaQuery.of(context).size.width *
                  0.53, // set the cell width to 80% of the screen width
              child: Text(
                data,
                overflow: TextOverflow
                    .ellipsis, // add ellipsis to the text if it overflows the cell
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ]);
      }).toList(),
    ),
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

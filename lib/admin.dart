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
  backgroundColor: Colors.white,
  elevation: 0,
  title: const Text(
    'Admin Page',
    style: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
  ),
  actions: [
    Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        },
        icon: const Icon(
          Icons.logout,
          size: 26.0,
          color: Colors.black,
        ),
      ),
    ),
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
crossAxisAlignment: CrossAxisAlignment.stretch,
children: [
Text(
'Activity Report',
style: TextStyle(
fontSize: 30,
color: Colors.blue[900],
fontWeight: FontWeight.w400,
),
),
const SizedBox(
height: 16,
),
Divider(
color: Colors.black38,
thickness: 1,
),
const SizedBox(
height: 16,
),
Expanded(
child: StreamBuilder<String>(
stream: bodyDataController.stream,
builder: (context, snapshot) {
if (snapshot.hasError) {
return Center(
child: Text(
"Error: ${snapshot.error}",
style: const TextStyle(
fontSize: 20,
color: Colors.red,
fontWeight: FontWeight.w400,
),
),
);
} else if (!snapshot.hasData) {
return Center(
child: Text(
"Loading...",
style: TextStyle(
fontSize: 20,
color: Colors.blue[500],
fontWeight: FontWeight.w400,
),
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

              return SingleChildScrollView(
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
                              0.45, // set the cell width to 80% of the screen width
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
              );
            }
          },
        ),
      ),
    ],
  ),
),
 ),),//Card
      ],
      ),
    );
  }
}

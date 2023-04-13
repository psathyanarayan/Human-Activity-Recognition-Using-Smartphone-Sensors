import 'dart:convert';

class SensorData {
  double Ax;
  double Ay;
  double Az;
  double LAx;
  double LAy;
  double LAz;
  double Gx;
  double Gy;
  double Gz;
  double Mx;
  double My;
  double Mz;

  SensorData(
      {required this.Ax,
      required this.Ay,
      required this.Az,
      required this.LAx,
      required this.LAy,
      required this.LAz,
      required this.Gx,
      required this.Gy,
      required this.Gz,
      required this.Mx,
      required this.My,
      required this.Mz
      });

  Map<String, dynamic> toJson() {
    return {'ax': Ax, 'ay': Ay, 'az': Az,'lax': LAx, 'lay': LAy, 'laz': LAz, 'gx': Gx, 'gy': Ay, 'gz': Gz,'mx': Gx, 'my': Ay, 'mz': Gz};
  }
}

String toJsonString(SensorData _accelerometerData) {
  // Append the data to a list
  List<Map<String, dynamic>> dataList = [];
  // dataList.add(_accelerometerData.toJson());

  // Create a nested JSON object
  // Map<String, dynamic> nestedJsonData = {'input1': dataList};

  // Combine the data into a single JSON object
  // Map<String, dynamic> jsonData = {'Inputs': nestedJsonData};

  // Convert to JSON string
  String jsonString = jsonEncode(_accelerometerData.toJson());

  // Return the JSON string
  return jsonString;
}

// void main() {
//   // Sample accelerometer and gyroscope data
//   SensorData _accelerometerData =
//       SensorData(Ax: 1.0, Ay: 2.0, Az: 3.0, Gx: 4.0, Gy: 5.0, Gz: 6.0);
//   print(_accelerometerData);
//   // Convert to JSON string
//   String jsonString = toJsonString(_accelerometerData);

//   // Print the JSON string
//   print(jsonString);
// }
        

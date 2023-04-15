import 'dart:convert';

class RetrainData {
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
  String activity;

  RetrainData(
    
    {
    required this.Ax,
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
    required this.Mz,
    required this.activity,
  });

  Map<String, dynamic> toJson() {
    return {
      'ax': Ax,
      'ay': Ay,
      'az': Az,
      'lax': LAx,
      'lay': LAy,
      'laz': LAz,
      'gx': Gx,
      'gy': Gy,
      'gz': Gz,
      'mx': Mx,
      'my': My,
      'mz': Mz,
      'activity' : activity
    };
  }
}

List<Map<String, dynamic>> toJsonString(RetrainData _accelerometerData) {
  // Append the data to a list
  List<Map<String, dynamic>> dataList = [];
  // dataList.add(_accelerometerData.toJson());

  // Create a nested JSON object
  // Map<String, dynamic> nestedJsonData = {'input1': dataList};

  // Combine the data into a single JSON object
  // Map<String, dynamic> jsonData = {'Inputs': nestedJsonData};

  // Convert to JSON string
  String jsonString = jsonEncode(_accelerometerData.toJson());
  dataList.add(_accelerometerData.toJson());
  // Return the JSON string
  return dataList;
}

// void main() {
//   // Sample accelerometer and gyroscope data
//   RetrainData _accelerometerData =
//       RetrainData(Ax: 1.0, Ay: 2.0, Az: 3.0, Gx: 4.0, Gy: 5.0, Gz: 6.0);
//   print(_accelerometerData);
//   // Convert to JSON string
//   String jsonString = toJsonString(_accelerometerData);

//   // Print the JSON string
//   print(jsonString);
// }
        

import 'dart:convert';
import 'dart:io';
import 'package:sensor_data_logging/MyHomePage.dart';

import 'package:http/http.dart' as http;
class ApiReq  {
  final data = {
    "Inputs": {
      "input1": [
        {
          "LP_Ax": 0.76274,
          "LP_Ay": -7.6546,
          "LP_Az": -0.38137,
          "LP_Lx": 0.42924,
          "LP_Ly": 2.136,
          "LP_Lz": -0.83239,
          "LP_Gx": 1.0259,
          "LP_Gy": -0.25168,
          "LP_Gz": 0.56994,
          "LP_Mx": 13.86,
          "LP_My": 36.36,
          "LP_Mz": 22.56,
          "RP_Ax": 1.58,
          "RP_Ay": -12.435,
          "RP_Az": -5.6933,
          "RP_Lx": 0.85475,
          "RP_Ly": -2.6614,
          "RP_Lz": -5.3563,
          "RP_Gx": 1.6661,
          "RP_Gy": -1.0986,
          "RP_Gz": 0.12156,
          "RP_Mx": 18.48,
          "RP_My": 56.1,
          "RP_Mz": 2.82,
          "WAx": 1.4438,
          "WAy": -7.5457,
          "WAz": 1.1713,
          "WLx": -3.9004,
          "WLy": 0.59369,
          "WLz": 0.0045235,
          "WGx": 0.99327,
          "WGy": -0.38759,
          "WGz": -2.5107,
          "WMx": -26.82,
          "WMy": 33.0,
          "WMz": 9.66,
          "UP_Ax": 1.8251,
          "UP_Ay": -7.5321,
          "UP_Az": 0.36775,
          "UP_Lx": -0.37045,
          "UP_Ly": 1.8885,
          "UP_Lz": 1.9811,
          "UP_Gx": -0.49572,
          "UP_Gy": 0.16463,
          "UP_Gz": -0.95051,
          "UP_Mx": -15.66,
          "UP_My": 34.38,
          "UP_Mz": 14.94,
          "BAx": 13.838,
          "BAy": -2.5198,
          "BAz": 0.92618,
          "BLx": 4.1484,
          "BLy": -1.4903,
          "BLz": -0.17676,
          "BGx": -0.58796,
          "BGy": -0.20831,
          "BGz": -0.32742,
          "BMx": -22.74,
          "BMy": 3.9,
          "BMz": 7.98,
          "activity": "1walking"
        },
        {
          "LP_Ax": 0.12258,
          "LP_Ay": -7.9543,
          "LP_Az": 0.31327,
          "LP_Lx": -0.19553,
          "LP_Ly": 1.8371,
          "LP_Lz": -0.13227,
          "LP_Gx": 0.8717,
          "LP_Gy": -2.3295,
          "LP_Gz": 0.55528,
          "LP_Mx": 33.0,
          "LP_My": 36.9,
          "LP_Mz": 20.94,
          "RP_Ax": 3.5004,
          "RP_Ay": -12.708,
          "RP_Az": -4.3721,
          "RP_Lx": 2.425,
          "RP_Ly": -3.0526,
          "RP_Lz": -3.0339,
          "RP_Gx": 0.08827,
          "RP_Gy": 1.9945,
          "RP_Gz": 0.32865,
          "RP_Mx": 17.88,
          "RP_My": 56.76,
          "RP_Mz": 1.2,
          "WAx": 1.3757,
          "WAy": -7.6274,
          "WAz": 1.1577,
          "WLx": -4.3344,
          "WLy": 0.24126,
          "WLz": -0.12696,
          "WGx": 0.92241,
          "WGy": -0.25107,
          "WGz": -2.4737,
          "WMx": -27.72,
          "WMy": 32.82,
          "WMz": 9.12,
          "UP_Ax": 2.0975,
          "UP_Ay": -8.2539,
          "UP_Az": 0.32689,
          "UP_Lx": -0.26905,
          "UP_Ly": 1.1172,
          "UP_Lz": 1.9856,
          "UP_Gx": -0.39645,
          "UP_Gy": 0.14691,
          "UP_Gz": -0.80879,
          "UP_Mx": -16.86,
          "UP_My": 33.66,
          "UP_Mz": 15.24,
          "BAx": 14.969,
          "BAy": -1.1032,
          "BAz": 2.5879,
          "BLx": 5.2609,
          "BLy": -0.15096,
          "BLz": 1.5773,
          "BGx": -0.47922,
          "BGy": -0.33659,
          "BGz": -0.29474,
          "BMx": -22.62,
          "BMy": 33.0,
          "BMz": 8.22,
          "activity": "1walking"
        },
        {
          "LP_Ax": 0.25879,
          "LP_Ay": -7.6683,
          "LP_Az": 0.35413,
          "LP_Lx": -0.048892,
          "LP_Ly": 2.1231,
          "LP_Lz": -0.098911,
          "LP_Gx": 1.1964,
          "LP_Gy": -2.7687,
          "LP_Gz": 0.39309,
          "LP_Mx": 17.22,
          "LP_My": 37.92,
          "LP_Mz": 33.0,
          "RP_Ax": 5.9112,
          "RP_Ay": -12.708,
          "RP_Az": -0.054481,
          "RP_Lx": 4.4238,
          "RP_Ly": -3.0862,
          "RP_Lz": 1.1213,
          "RP_Gx": -0.58063,
          "RP_Gy": 2.6612,
          "RP_Gz": 0.0045815,
          "RP_Mx": 17.7,
          "RP_My": 56.94,
          "RP_Mz": 0.6,
          "WAx": 1.3212,
          "WAy": -7.8589,
          "WAz": 1.2122,
          "WLx": -4.7088,
          "WLy": -0.253,
          "WLz": -0.18742,
          "WGx": 0.80054,
          "WGy": -0.1069,
          "WGz": -2.3906,
          "WMx": -29.64,
          "WMy": 32.4,
          "WMz": 7.98,
          "UP_Ax": 2.3972,
          "UP_Ay": -9.0303,
          "UP_Az": -0.054481,
          "UP_Lx": -0.14155,
          "UP_Ly": 0.28893,
          "UP_Lz": 1.6418,
          "UP_Gx": -0.27886,
          "UP_Gy": 0.099876,
          "UP_Gz": -0.64507,
          "UP_Mx": -17.94,
          "UP_My": 33.0,
          "UP_Mz": 15.72,
          "BAx": 13.239,
          "BAy": -0.99429,
          "BAz": 3.051,
          "BLx": 3.5178,
          "BLy": -0.077435,
          "BLz": 2.1406,
          "BGx": 0.94073,
          "BGy": -1.1139,
          "BGz": -0.010996,
          "BMx": -22.68,
          "BMy": 2.64,
          "BMz": 8.28,
          "activity": "1walking"
        },
        {
          "LP_Ax": 1.0624,
          "LP_Ay": -8.6625,
          "LP_Az": 0.25879,
          "LP_Lx": 0.66912,
          "LP_Ly": 1.1264,
          "LP_Lz": -0.17875,
          "LP_Gx": 1.591,
          "LP_Gy": -2.1545,
          "LP_Gz": 0.10507,
          "LP_Mx": 18.18,
          "LP_My": 38.28,
          "LP_Mz": 16.5,
          "RP_Ax": 5.9793,
          "RP_Ay": -12.258,
          "RP_Az": -0.74912,
          "RP_Lx": 4.1312,
          "RP_Ly": -2.6906,
          "RP_Lz": 0.35237,
          "RP_Gx": -0.84941,
          "RP_Gy": 2.8656,
          "RP_Gz": -0.38607,
          "RP_Mx": 17.52,
          "RP_My": 33.0,
          "RP_Mz": 0.12,
          "WAx": 1.1305,
          "WAy": -7.9543,
          "WAz": 1.3757,
          "WLx": -5.3393,
          "WLy": -0.75201,
          "WLz": -0.18619,
          "WGx": 0.66462,
          "WGy": 0.065668,
          "WGz": -2.2626,
          "WMx": -31.14,
          "WMy": 32.04,
          "WMz": 6.72,
          "UP_Ax": 2.5198,
          "UP_Ay": -9.8203,
          "UP_Az": -0.70826,
          "UP_Lx": -0.13669,
          "UP_Ly": -0.53654,
          "UP_Lz": 1.0023,
          "UP_Gx": -0.1631,
          "UP_Gy": 0.033903,
          "UP_Gz": -0.46426,
          "UP_Mx": -19.14,
          "UP_My": 32.4,
          "UP_Mz": 16.08,
          "BAx": 11.101,
          "BAy": -1.0624,
          "BAz": 1.6753,
          "BLx": 1.3707,
          "BLy": -0.1551,
          "BLz": 0.85328,
          "BGx": 1.2666,
          "BGy": -1.741,
          "BGz": 0.17257,
          "BMx": -22.5,
          "BMy": 2.22,
          "BMz": 8.34,
          "activity": "1walking"
        },
        {
          "LP_Ax": 1.7025,
          "LP_Ay": -9.902,
          "LP_Az": 0.88532,
          "LP_Lx": 1.0555,
          "LP_Ly": -0.12934,
          "LP_Lz": 0.38833,
          "LP_Gx": 1.5953,
          "LP_Gy": -1.4279,
          "LP_Gz": -0.22419,
          "LP_Mx": 19.86,
          "LP_My": 38.76,
          "LP_Mz": 13.62,
          "RP_Ax": 5.8567,
          "RP_Ay": -12.64,
          "RP_Az": -1.0351,
          "RP_Lx": 3.7184,
          "RP_Ly": -3.1277,
          "RP_Lz": 0.022911,
          "RP_Gx": -0.12767,
          "RP_Gy": 2.3824,
          "RP_Gz": -0.51374,
          "RP_Mx": 17.28,
          "RP_My": 57.3,
          "RP_Mz": -0.18,
          "WAx": 1.1305,
          "WAy": -8.0905,
          "WAz": 1.3893,
          "WLx": -5.4568,
          "WLy": -1.0077,
          "WLz": -0.22657,
          "WGx": 0.51007,
          "WGy": 0.23702,
          "WGz": -2.0678,
          "WMx": -31.74,
          "WMy": 31.62,
          "WMz": 6.12,
          "UP_Ax": 2.5334,
          "UP_Ay": -10.42,
          "UP_Az": -0.8717,
          "UP_Lx": -0.15283,
          "UP_Ly": -1.144,
          "UP_Lz": 0.83659,
          "UP_Gx": -0.049175,
          "UP_Gy": -0.041233,
          "UP_Gz": -0.31612,
          "UP_Mx": -20.04,
          "UP_My": 31.74,
          "UP_Mz": 16.62,
          "BAx": 7.3141,
          "BAy": -1.1986,
          "BAz": 0.28603,
          "BLx": -2.4399,
          "BLy": -0.25717,
          "BLz": -0.091939,
          "BGx": 0.90255,
          "BGy": -1.8363,
          "BGz": 0.45723,
          "BMx": -22.32,
          "BMy": 1.62,
          "BMz": 8.7,
          "activity": "1walking"
        }
      ]
    },
    "GlobalParameters": {}
  };

  sendApi(acc) async {
    final body = utf8.encode(json.encode(data));
    var response = await http.post(
        Uri.parse(
            "http://d24092b1-2885-4399-94ad-98ed670c9392.centralindia.azurecontainer.io/score"),
        headers: {
          'Authorization': 'Bearer EOdpCJU7dxhyny4F81F4iFhtqbA7T0No',
        },
        body: body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    final result = response.body;
    var jsonData = jsonDecode(result);
    print(jsonData['Results']['WebServiceOutput0'][0]['Scored Labels']);
    // print(_userAccelerometerValues);

    // print(await http.read(Uri.https(
    //     'http://d24092b1-2885-4399-94ad-98ed670c9392.centralindia.azurecontainer.io/score')));
  }
}


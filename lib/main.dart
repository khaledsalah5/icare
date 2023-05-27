import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:icare/screens/login_screen.dart';

late int BTdata;
late Map SpO2data;
late Map ECGdata;
late Map NIBPdata;

// Stream<List<SensorData>> getBTData() async* {
//   var headers = {'Content-Type': 'application/json'};
//   var request = http.Request('GET',
//       Uri.parse('http://10.23.246.243/api/DisplaySensorValue?sensor=BT'));
//   request.headers.addAll(headers);
//   while (true) {
//     http.StreamedResponse response = await request.send();
//     final respStr = await response.stream.bytesToString();
//     print(respStr);
//     List<SensorData> sensorDataList = [];
//     var jsonData = jsonDecode(respStr)["data"];
//     for (var data in jsonData) {
//       SensorData sensorData = SensorData(data["name"], data["value"]);
//       sensorDataList.add(sensorData);
//     }
//     yield sensorDataList;
//     await Future.delayed(Duration(
//         milliseconds:
//             300)); // Wait for 300 milliseconds before the next request
//   }
// }

Future<void> gettBTData() async {
  Timer.periodic(Duration(milliseconds: 300), (timer) async {
    //timer.cancel();
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('GET',
        Uri.parse('http://10.23.246.243/api/DisplaySensorValue?sensor=BT'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(respStr);
    BTdata = jsonDecode(respStr)["data"];
    print(BTdata);
  });
}

Future<void> getSpO2Data() async {
  Timer.periodic(Duration(milliseconds: 300), (timer) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('GET',
        Uri.parse('http://10.23.246.243/api/DisplaySensorValue?sensor=SpO2'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(respStr);
    SpO2data = jsonDecode(respStr)["data"];
    print(SpO2data['spO2']); //spo2 value   //SpO2data['hrv']
  });
}

Future<void> getECGData() async {
  Timer.periodic(Duration(milliseconds: 2300), (timer) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('GET',
        Uri.parse('http://10.23.246.243/api/DisplaySensorValue?sensor=ECG'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(respStr);
    ECGdata = jsonDecode(respStr)["data"];
    print(ECGdata['ecg']); //ecg value //  ECGdata['hrv']
  });
}

Future<void> getNIBPData() async {
  Timer.periodic(Duration(milliseconds: 2300), (timer) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('GET',
        Uri.parse('http://10.23.246.243/api/DisplaySensorValue?sensor=NIBP'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(respStr);
    NIBPdata = jsonDecode(respStr)["data"];
    print(NIBPdata['sbp']); //الضغط value  //NIBPdata['dbp']      NIBPdata['hr']
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

// ignore: unused_local_variable
var box = await Hive.openBox('notes');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      theme: ThemeData(),
      home: LoginScreen(),
    );
  }
}

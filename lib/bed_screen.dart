import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'components/model.dart';
import 'package:audioplayers/audioplayers.dart';

class bedScreen extends StatefulWidget {
  @override
  State<bedScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<bedScreen> {
  late Map SpO2data;
  final player = AudioPlayer();
 // int btValue = 42, ecgValue = 120, spo2Value = 99;

  late Map ECGdata;
  late String BPMValue = '0';
  late String ECGValue = '0';
  late int ECGValue1 = 0;

  late Map NIBPdata;

  late String SpO2Value = '0';

  late String HRVValue = '0';
  late String BTdata = '0';
  late String hr = '0';
  late String dbp = '0';
  late String sbp = '0';

  static const int updatetime = 300;

  List<DataPoint> dataPoints = [];
  Timer? timer;
  int maximumDataPoints = 5000; // Maximum number of data points to display

  @override
  void initState() {
    super.initState();

    getSpO2Data();
    //getECGData();
    gettBTData();
    getNIBPData();
    //checkBluetoothValue();

    fetchData(); // Fetch initial data when the screen loads
    timer = Timer.periodic(Duration(milliseconds: updatetime),
        (Timer t) => fetchData()); // Fetch data every 300 milliseconds
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer when the screen is disposed
    super.dispose();
  }

  Future<void> getSpO2Data() async {
    Timer.periodic(Duration(milliseconds: updatetime), (timer) async {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('GET',
          Uri.parse('http://10.23.247.22/api/DisplaySensorValue?sensor=SpO2'));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      final respStr = await response.stream.bytesToString();
      setState(() {
        SpO2data = jsonDecode(respStr)["data"];
        SpO2Value = SpO2data['spO2'].toString();
        HRVValue = SpO2data['hrv'].toString();
        checkBluetoothValue();
      });

      // print(SpO2data['spO2']); //spo2 value   //SpO2data['hrv']
    });
  }

  Future<void> gettBTData() async {
    Timer.periodic(Duration(milliseconds: updatetime), (timer) async {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('GET',
          Uri.parse('http://10.23.247.22/api/DisplaySensorValue?sensor=BT'));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      final respStr = await response.stream.bytesToString();
      setState(() {
        BTdata = jsonDecode(respStr)["data"].toString();
        // BTValue = BTdata.toString();
      });

      //print(BTdata);
    });
  }

  // Future<void> getECGData() async {
  //   Timer.periodic(Duration(milliseconds: updatetime), (timer) async {
  //     var headers = {'Content-Type': 'application/json'};
  //     var request = http.Request('GET',
  //         Uri.parse('http://10.23.246.243/api/DisplaySensorValue?sensor=ECG'));
  //     request.headers.addAll(headers);
  //     http.StreamedResponse response = await request.send();
  //     final respStr = await response.stream.bytesToString();
  //     print(respStr);
  //     setState(() {
  //       //y++;
  //       ECGdata = jsonDecode(respStr)["data"];
  //       BPMValue = ECGdata["ecgBpm"].toString();
  //       ECGValue = ECGdata["ecg"].toString();
  //       ECGValue1 = ECGdata["ecg"];
  //     });
  //     //print(ECGdata['ecg']); //ecg value //  ECGdata['hrv']
  //   });
  // }

  Future<void> getNIBPData() async {
    Timer.periodic(Duration(milliseconds: updatetime), (timer) async {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('GET',
          Uri.parse('http://10.23.247.22/api/DisplaySensorValue?sensor=NIBP'));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      final respStr = await response.stream.bytesToString();
      setState(() {
        NIBPdata = jsonDecode(respStr)["data"];
        hr = NIBPdata['hr'].toString();
        sbp = NIBPdata['sbp'].toString();
        dbp = NIBPdata['dbp'].toString();

        checkBluetoothValue();
      });

      //  print(NIBPdata['sbp']); //الضغط value  //NIBPdata['dbp']      NIBPdata['hr']
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 80,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 19, 166, 192),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Name:" + PatientName),
                    Text("Age:" + PatientAge),
                    Text("Phone:" + PatientNum),
                  ],
                ),
              ],
            ),
          ),
          Text(
            "ECG Chart",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 20, 35, 87)),
          ),
          Container(
            alignment: Alignment.topRight,
            margin:
                EdgeInsets.only(right: 10.0), // adjust the value as you need
            child: iconData('BPM', BPMValue),
          ),
          Container(
            margin: EdgeInsets.only(right: 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 350,
                  child: ECGChart(dataPoints),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        iconData('SpO2 ', SpO2Value),
                        iconData('HRV', HRVValue),
                        iconData('BT', BTdata),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        iconData('HR', hr),
                        iconData('DBP', dbp),
                        iconData('SBP', sbp)
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20.0),
                Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text("   Note"),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              color: Colors.white,
                              child: TextField(
                                // controller: controller, Textinputcontroller controller ; controller.text
                                minLines: 1,
                                maxLines: 5,
                                keyboardType: TextInputType.multiline,
                                decoration:
                                    InputDecoration(alignLabelWithHint: false),
                              ),
                            )),
                        CheckboxExample()
                      ]),
                )
              ],
            ),
          )
        ]),
      ),
    ));
  }

  void checkBluetoothValue() {
    if ((int.parse(BTdata) < 30 ||
        int.parse(BTdata) > 38 ) && int.parse(BTdata) != 0

        // ECGValue1> 130 ||
        // ECGValue1 < 50 ||
        // int.parse(SpO2Value) < 95
        )
         {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // Play sound when dialog is shown
          player.play(AssetSource('sound/censor-beep-10sec-8113.mp3'));
          return AlertDialog(
            title: Text('Alert'),
            content: Text(
                'The values have dropped to BT: $BTdata ECG: $ECGValue1 SpO2: $SpO2Value !'),
            actions: <Widget>[
              MaterialButton(
                child: Text('OK'),
                onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
              return bedScreen();
            }));
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> fetchData() async {
    Timer.periodic(Duration(milliseconds: updatetime), (timer) async {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('GET',
          Uri.parse('http://10.23.247.22/api/DisplaySensorValue?sensor=ECG'));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      final respStr = await response.stream.bytesToString();
      print(respStr);
      setState(() {
        ECGdata = jsonDecode(respStr)["data"];
        ECGValue1 = ECGdata["ecg"];

        dataPoints.add(DataPoint(
          time: DateTime.now(),
          value: ECGValue1,
        ));
      });

      if (dataPoints.length > maximumDataPoints) {
        dataPoints.removeAt(0);
        // Remove the oldest data point if the list exceeds the maximum
      }
    });
  }
}

class DataPoint {
  final DateTime time;
  final int value;
  DataPoint({required this.time, required this.value});
}

Widget ECGChart(List<DataPoint> dataPoints1) {
  return Container(
    child: SfCartesianChart(
        primaryXAxis: DateTimeAxis(isVisible: false),
        series: <LineSeries<DataPoint, DateTime>>[
          LineSeries<DataPoint, DateTime>(
            dataSource: dataPoints1,
            xValueMapper: (DataPoint data, _) => data.time,
            yValueMapper: (DataPoint data, _) => data.value,
          ),
        ],
        // title: ChartTitle(text: 'ECG Chart'),
        primaryYAxis: NumericAxis(
            axisLine: const AxisLine(width: 0),
            majorTickLines: const MajorTickLines(size: 0),
            title: AxisTitle(text: 'Heart Rate'))),
  );
}




class CheckboxExample extends StatefulWidget {
  const CheckboxExample({Key? key}) : super(key: key);

  @override
  _CheckboxExampleState createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxExample> {
  bool isChecked1 = false;
  bool isChecked2 = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith(getColor),
              value: isChecked1,
              onChanged: (bool? value) {
                setState(() {
                  isChecked1 = value!;
                });
              },
            ),
            const Text('Medicine 1'),
          ],
        ),
        Row(
          children: [
            Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith(getColor),
              value: isChecked2,
              onChanged: (bool? value) {
                setState(() {
                  isChecked2 = value!;
                });
              },
            ),
            const Text('Medicine 2'),
          ],
        ),
      ],
    );
  }
}

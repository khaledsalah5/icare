import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'model.dart';



class bedScreen extends StatefulWidget {
  @override
  State<bedScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<bedScreen> {
  // _MyScreenState();
  List<LiveData> chartData = <LiveData>[
    LiveData(0, 0),
    LiveData(0.3, 90),
    LiveData(0.6, -10),
    LiveData(0.9, 0),
    LiveData(1.2, 18),
    LiveData(1.5, 20),
    LiveData(1.8, 18),
    LiveData(2.1, 0),
    LiveData(3, 5),
    LiveData(7, 200),
    LiveData(8, 1),
    LiveData(9, 41),
    LiveData(10, 500),
    LiveData(11, 0),
    LiveData(12, 0),
    LiveData(16, 0),
    LiveData(17, 72),
    LiveData(18, 2)
  ];

  late ChartSeriesController _chartSeriesController;

  late Map SpO2data;

  late Map ECGdata;
  late String BPMValue = '0';
  late String ECGValue = '0';
  late int ECGValue1 = 0;

  late Map NIBPdata;

  late String SpO2Value = '';

  late String HRVValue = '';
  late String BTdata = '';
  late String hr = '';
  late String dbp = '';
  late String sbp = '';

  static const int updatetime = 300;

  @override
  void initState() {
    super.initState();
    // chartData = getChartData();
    Timer.periodic(const Duration(milliseconds: updatetime), updateDataSource);
    getSpO2Data();
    getECGData();
    gettBTData();
    getNIBPData();
  }

  Future<void> getSpO2Data() async {
    Timer.periodic(Duration(milliseconds: updatetime), (timer) async {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('GET',
          Uri.parse('http://10.23.246.243/api/DisplaySensorValue?sensor=SpO2'));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      final respStr = await response.stream.bytesToString();
      setState(() {
        SpO2data = jsonDecode(respStr)["data"];
        SpO2Value = SpO2data['spO2'].toString();
        HRVValue = SpO2data['hrv'].toString();
      });

      // print(SpO2data['spO2']); //spo2 value   //SpO2data['hrv']
    });
  }

  Future<void> gettBTData() async {
    Timer.periodic(Duration(milliseconds: updatetime), (timer) async {
      //timer.cancel();
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('GET',
          Uri.parse('http://10.23.246.243/api/DisplaySensorValue?sensor=BT'));
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

  Future<void> getECGData() async {
    Timer.periodic(Duration(milliseconds: updatetime), (timer) async {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('GET',
          Uri.parse('http://10.23.246.243/api/DisplaySensorValue?sensor=ECG'));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      final respStr = await response.stream.bytesToString();
      print(respStr);
      setState(() {
        ECGdata = jsonDecode(respStr)["data"];
        BPMValue = ECGdata["ecgBpm"].toString();
        ECGValue = ECGdata["ecg"].toString();
        ECGValue1 = ECGdata["ecg"];
      });
      //print(ECGdata['ecg']); //ecg value //  ECGdata['hrv']
    });
  }

  Future<void> getNIBPData() async {
    Timer.periodic(Duration(milliseconds: updatetime), (timer) async {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('GET',
          Uri.parse('http://10.23.246.243/api/DisplaySensorValue?sensor=NIBP'));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      final respStr = await response.stream.bytesToString();
      setState(() {
        NIBPdata = jsonDecode(respStr)["data"];
        hr = NIBPdata['hr'].toString();
        sbp = NIBPdata['sbp'].toString();
        dbp = NIBPdata['dbp'].toString();
      });

      //  print(NIBPdata['sbp']); //الضغط value  //NIBPdata['dbp']      NIBPdata['hr']
    });
  }

  //print(y.toString());
  // change y  by the bpm rate
  void updateDataSource(Timer timer) {
    double time = 19.0;
    int y = ECGValue1;
    print('aaaaaaaaaaaaaaaaaaaaaa      ' + y.toString());
    chartData.add(LiveData(time += 0.3, y=ECGValue1));
    chartData.removeAt(0);
    _chartSeriesController.updateDataSource(
        addedDataIndex: chartData.length - 1, removedDataIndex: 0);
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
                    child: SfCartesianChart(
                        series: <LineSeries<LiveData, double>>[
                          LineSeries<LiveData, double>(
                            onRendererCreated:
                                (ChartSeriesController controller) {
                              _chartSeriesController = controller;
                            },
                            dataSource: chartData,
                            color: const Color.fromRGBO(192, 108, 132, 1),
                            xValueMapper: (LiveData sales, _) => sales.time,
                            yValueMapper: (LiveData sales, _) => sales.y,
                          )
                        ],
                        primaryXAxis: NumericAxis(
                            majorGridLines: const MajorGridLines(width: 0),
                            edgeLabelPlacement: EdgeLabelPlacement.shift,
                            interval: 1,
                            title: AxisTitle(text: 'Time (seconds)')),
                        primaryYAxis: NumericAxis(
                            axisLine: const AxisLine(width: 0),
                            majorTickLines: const MajorTickLines(size: 0),
                            title: AxisTitle(text: 'Heart Rate')))),
                Column(
                  children: [
                    Row(
                      children: [
                        iconData('spO2 ', SpO2Value),
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
                      ]),
                )
              ],
            ),
          )
        ]),
      ),
    ));
  }

  // double time = 19.0;

  // int y=0 ;
  // //print(y.toString());
  // // change y  by the bpm rate
  // void updateDataSource(Timer timer) {
  //   print('aaaaaaaaaaaaaaaaaaaaaa      '+ECGValue1.toString());
  //   chartData.add(LiveData(time +=0.3, y ));
  //   chartData.removeAt(0);
  //   _chartSeriesController.updateDataSource(
  //       addedDataIndex: chartData.length - 1, removedDataIndex: 0);
  // }

  // List<LiveData> getChartData() {
  //   return <LiveData>[
  //     LiveData(0, 0),
  //     LiveData(0.3, 90),
  //     LiveData(0.6, -10),
  //     LiveData(0.9, 0),
  //     LiveData(1.2, 18),
  //     LiveData(1.5, 20),
  //     LiveData(1.8, 18),
  //     LiveData(2.1, 0),
  //     LiveData(3, 5),
  //     LiveData(7, 200),
  //     LiveData(8, 1),
  //     LiveData(9, 41),
  //     LiveData(10, 500.9),
  //     LiveData(11, 72.1),
  //     LiveData(12, 86),
  //     LiveData(16, 86),
  //     LiveData(17, 72),
  //     LiveData(18, 2)
  //   ];
  // }
}

class LiveData {
  LiveData(this.time, this.y);
  final double time;
  final int y;
}

Widget iconData(String name, String value) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(alignment: Alignment.center, children: [
        Container(
          height: 52,
          width: 52,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(15)),
        ),
        Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(246, 255, 255, 255),
              borderRadius: BorderRadius.circular(15)),
          width: 50,
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(name),
              Text(value),
            ],
          ),
        ),
      ]),
    );

// class dataa {
//   dataa(String ecg);
//   late String ecg;
// }
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:icare/bed_screen.dart';
import 'package:icare/pages/main_page.dart';
import 'package:icare/screens/add_modify_user_screen.dart';
import 'components/model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

late User user;


class roomScreen extends StatefulWidget {
  roomScreen({required user1}) {
    

    user = user1;
  }

  @override
  State<roomScreen> createState() => _roomScreenState();
}

class _roomScreenState extends State<roomScreen> {
  late String BTdata2 = '';
  late Map SpO2data2;
  late String SpO2Value2 = '';
  late Map ECGdata2;
  late String BPMValue2 = '';

  Future<void> getBTData() async {
    Timer.periodic(Duration(milliseconds: 300), (timer) async {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('GET',
          Uri.parse('http://10.23.247.22/api/DisplaySensorValue?sensor=BT'));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      final respStr = await response.stream.bytesToString();
      setState(() {
        BTdata2 = jsonDecode(respStr)["data"].toString();
      });
    });
  }

  Future<void> getSpO2Data2() async {
    Timer.periodic(Duration(milliseconds: 300), (timer) async {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('GET',
          Uri.parse('http://10.23.247.22/api/DisplaySensorValue?sensor=SpO2'));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      final respStr = await response.stream.bytesToString();
      setState(() {
        SpO2data2 = jsonDecode(respStr)["data"];
        SpO2Value2 = SpO2data2['spO2'].toString();
      });
      // print(SpO2data['spO2']); //spo2 value   //SpO2data['hrv']
    });
  }

  Future<void> getECGData2() async {
    Timer.periodic(Duration(milliseconds: 300), (timer) async {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('GET',
          Uri.parse('http://10.23.247.22/api/DisplaySensorValue?sensor=ECG'));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      final respStr = await response.stream.bytesToString();
      print(respStr);
      setState(() {
        ECGdata2 = jsonDecode(respStr)["data"];
        BPMValue2 = ECGdata2["ecgBpm"].toString();
      });
      //print(ECGdata['ecg']); //ecg value //  ECGdata['hrv']
    });
  }

  @override
  void initState() {
    super.initState();
    getBTData();
    getSpO2Data2();
    getECGData2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 15, 119, 138),
        title: Text('Intensive Care Room'),
      ),
      drawer: Drawer(
        width: double.infinity,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 16, 126, 145),
              ),
              // currentAccountPicture: IconButton(
              //   onPressed: () {},
              //   icon: CircleAvatar(
              //     radius: 100,
              //     backgroundImage: AssetImage('assets/nurs.png'),
              //   ),
              // ),
              accountName: Text('${user.username}'),
              accountEmail: Text(user.email),
            ),
            ListTile(
              title: Text('Edit profile'),
              leading: Icon(Icons.edit),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddModifyUserScreen(
                              user.username,
                              user.email,
                              user.id,
                              user.gender,
                              user.job,
                              user.phoneNumber,
                              user.address,
                              user.password,
                              user.speciality,
                              user.age,
                              isUser1: true,
                            )));
              },
            ),
            ListTile(
              title: Text('Note'),
              leading: Icon(Icons.person),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainPage()));
              },
            ),
          ],
        ),
      ),
      body: Container(
        child: GestureDetector(
          child: PatientWidget(BTdata2, SpO2Value2, BPMValue2),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return bedScreen();
            }));
          },
        ),
      ),
    );
  }
}

Widget PatientWidget(String BTdata, String SpO2Value, String BPMValue2) {
  return Container(
    height: 110,
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 19, 166, 192),
      border: Border.all(color: Colors.black, width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Text(
              "Patient's Name:  " + PatientName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Text("Patient ID: 5", style: TextStyle(fontSize: 16)),
            Spacer(),
            Text("Age: " + PatientAge, style: TextStyle(fontSize: 16)),
            Spacer(),
            Text("Gender: " + PatientGender, style: TextStyle(fontSize: 16)),
            Spacer(),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Spacer(),
            Text("spO2:" + SpO2Value, style: TextStyle(fontSize: 16)),
            Spacer(),
            Text("Temp:" + BTdata, style: TextStyle(fontSize: 16)),
            Spacer(),
            Text("Bpm:" + BPMValue2, style: TextStyle(fontSize: 16)),
            Spacer(),
          ],
        ),
      ],
    ),
  );
}

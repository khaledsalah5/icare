import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

Future<Map<String,dynamic>> getSpO2Data() async {
late Map SpO2data = {
  "status": "Success",
  "message": "SpO2 value from sensor",
  "data": {"spO2": 0, "hrv": 0}
};
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('GET',
        Uri.parse('http://10.23.246.243/api/DisplaySensorValue?sensor=SpO2'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();
    print('\n ---1hreeeeeeeeeeeeeeeeeeeeeeee-------------------- \n');
    print(respStr);
    //users.add(jsonDecode(respStr)["message"]);
    SpO2data = jsonDecode(respStr)["data"];
    print('\n ---hreeeeeeeeeeeeeeeeeeeeeeee-------------------- \n');
    print(SpO2data);
    print(SpO2data['spO2']); //spo2 value
  return SpO2data['data'];
}
 
class bedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: bedScreen1(),
    );
  }
}

class bedScreen1 extends StatefulWidget {
  void initState() {

      getSpO2Data();

  }

  @override
  State<bedScreen1> createState() => _bedScreenState();
}

class _bedScreenState extends State<bedScreen1> {

  @override
  Widget build(BuildContext context) {
   // Map<String,dynamic> data= await getSpO2Data();
    return Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.blue,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text("name"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("age"),
                          ),
                          Text("phone")
                        ],
                      ),
                      Column(
                        children: [
                          Text(""),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(""),
                          ),
                          Text("")
                        ], //
                      ),
                    ],
                  ),
                  Text(
                    "Charts",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 20, 35, 87)),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text("ECG"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            child: null,
                            color: Colors.white,
                            height: 175,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [Text("heart rate"), Text("")],
                              ),
                              Row(
                                children: [
                                  Text("blood pressure"),
                                //  Text("   ${getSpO2Data(). }")
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text("note"),
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child:
                                    Container(
                                      color: Colors.white,
                                      child: TextField(
                                        minLines: 1,
                                        maxLines: 5,
                                        keyboardType: TextInputType.multiline,
                                        decoration: InputDecoration(
                                            alignLabelWithHint: false),
                                      ),
                                    )
                                    ),
                              ]),
                        )
                      ],
                    ),
                  )
                ]),
          ),
        ));
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:icare/screens/constants.dart';
import 'package:icare/components/rounded_button.dart';
import 'package:http/http.dart' as http;
import 'package:icare/components/key.dart';

class AddModifyUserScreen extends StatelessWidget {
  late String name;
  late String email;
  late String gender;
 // late String status;
  late int id;

late String specialization;
late int age;
late int phone_num;
late String pass;

  late bool willAdd;

  AddModifyUserScreen(
      {this.email = '',
      this.name = '',
      this.gender = '',
  //    this.status = '',

      this.specialization = '',
      this.age = 0,
      this.phone_num=0,
      this.pass='',

      this.id = 0}) {
    willAdd = name.isEmpty;
  }

  Future<int> addUser(
      String name, String email, String gender, String specialization , int phone_num ,int age , String pass) async {
    var headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    };
    var request =
        http.Request('POST', Uri.parse('https://gorest.co.in/public/v2/users'));
    request.body = json.encode(
        {"email": email, "name": name, "gender": gender , "age": age ,"specialization": specialization,"phone_num": phone_num, "password": pass });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(respStr);

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    return response.statusCode;
  }

  Future<int> modifyUser(
      String name, String email, String gender, String specialization , int phone_num ,int age , String pass) async {
    var headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'PATCH', Uri.parse('https://gorest.co.in/public/v2/users/$id'));
request.body = json.encode(
        {"email": email, "name": name, "gender": gender , "age": age ,"specialization": specialization,"phone_num": phone_num, "password": pass });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();
    print(respStr);
    return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xffF2F2F2),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          decoration: const BoxDecoration(
            color: Color(0xffF2F2F2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Center(
              //   child: Text(
              //     willAdd ? 'Add User' : 'Modify User',
              //     style: const TextStyle(
              //       fontSize: 40.0,
              //       fontWeight: FontWeight.w500,
              //       color: Color(0xff383838),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: name.isEmpty
                    ? TextEditingController()
                    : TextEditingController(text: name),
                onChanged: (value) {
                  name = value;
                },
                autofocus: true,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                          hintText: 'Name',
                          hintStyle: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 104, 104, 104)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 29, 226, 88)),
                            borderRadius: BorderRadius.circular(15),
                          )),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: email.isEmpty
                    ? TextEditingController()
                    : TextEditingController(text: email),
                onChanged: (value) {
                  email = value;
                },
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 104, 104, 104)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 29, 226, 88)),
                            borderRadius: BorderRadius.circular(15),
                          )),
              ),
              const SizedBox(
                height: 20.0,
              ),

              TextField(
                controller: specialization.isEmpty
                    ? TextEditingController()
                    : TextEditingController(text: specialization),
                onChanged: (value) {
                  specialization = value;
                },
                autofocus: true,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                          hintText: 'Specialization',
                          hintStyle: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 104, 104, 104)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 29, 226, 88)),
                            borderRadius: BorderRadius.circular(15),
                          )),
              ),

              const SizedBox(
                height: 20.0,
              ),

              TextField(
              //  controller: phone_num.isEmpty
                 //   ? TextEditingController()
               //     : TextEditingController(text: phone_num),
                onChanged: (value) {
                  gender = value;
                },
                autofocus: true,
                textAlign: TextAlign.center,
                keyboardType:TextInputType.phone,
                decoration: InputDecoration(
                          hintText: 'phone number',
                          hintStyle: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 104, 104, 104)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 29, 226, 88)),
                            borderRadius: BorderRadius.circular(15),
                          ))
              ),

              const SizedBox(
                height: 20.0,
              ),

              TextField(
                //controller: phone_num.isEmpty
                  //  ? TextEditingController()
                    //: TextEditingController(text: phone_num),
                onChanged: (value) {
                  gender = value;
                },
                autofocus: true,
                textAlign: TextAlign.center,
                keyboardType:TextInputType.phone,
                decoration: InputDecoration(
                          hintText: 'Age',
                          hintStyle: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 104, 104, 104)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 29, 226, 88)),
                            borderRadius: BorderRadius.circular(15),
                          ))
              ),

                      

              const SizedBox(
                height: 20.0,
              ),

              TextField(
                controller: gender.isEmpty
                    ? TextEditingController()
                    : TextEditingController(text: gender),
                onChanged: (value) {
                  gender = value;
                },
                autofocus: true,
                textAlign: TextAlign.center,
decoration: InputDecoration(
                          hintText: 'Gender',
                          hintStyle: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 104, 104, 104)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 29, 226, 88)),
                            borderRadius: BorderRadius.circular(15),
                          )),
              ),

//               const SizedBox(
//                 height: 20.0,
//               ),
//               TextField(
//                 controller: status.isEmpty
//                     ? TextEditingController()
//                     : TextEditingController(text: status),
//                 onChanged: (value) {
//                   status = value;
//                 },
//                 autofocus: true,
//                 textAlign: TextAlign.center,
// decoration: InputDecoration(
//                           hintText: 'Status',
//                           hintStyle: TextStyle(
//                             color: Colors.grey[700],
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15,
//                           ),
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Color.fromARGB(255, 104, 104, 104)),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.grey),
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Color.fromARGB(255, 29, 226, 88)),
//                             borderRadius: BorderRadius.circular(15),
//                           )),
//               ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: pass.isEmpty
                    ? TextEditingController()
                    : TextEditingController(text: pass),
                onChanged: (value) {
                  pass = value;
                },
                autofocus: true,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                          hintText: 'password',
                          hintStyle: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 104, 104, 104)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 29, 226, 88)),
                            borderRadius: BorderRadius.circular(15),
                          ))
              ),


              RoundedButton(
                color: const Color(0xff066163),
                onPressed: () async {
                  if (willAdd) {
                    if (email != '' &&
                        name != '' &&
                        gender != '' &&
                        specialization !=''&&
                        phone_num !=0&&
                        age !=0
                        //pass!=''
                        ) {
                      int statusCode =
                          await addUser(name, email, gender,  specialization ,  phone_num , age ,  pass);
                      if (statusCode == 201) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 2000),
                            content: Text(
                              'User added successFully',
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } 
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 2000),
                            content: Text(
                              'Something went wrong, Please try again!',
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                            ),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                      }
                      Navigator.pop(context, statusCode);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 2000),
                          content: Text(
                            'Fill all the details!',
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                          backgroundColor: Color(0xff066163),
                        ),
                      );
                    }
                  } else {
                    int statusCode =
                        await modifyUser(name, email, gender,   specialization ,  phone_num , age ,  pass);
                    if (statusCode == 200) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 2000),
                          content: Text(
                            'User Modified successFully',
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 2000),
                          content: Text(
                            'Something went wrong, Please try again!',
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
                    Navigator.pop(context, statusCode);
                  }
                },
                title: (willAdd) ? 'Add' : 'Modify',
              )
            ],
          ),
        ),
      ),
    );
  }
}

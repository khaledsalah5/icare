import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:icare/components/constants.dart';
import 'package:icare/components/rounded_button.dart';
import 'package:http/http.dart' as http;
import 'package:icare/components/key.dart';
import 'package:icare/screens/login_screen.dart';
import 'package:icare/screens/users_screen.dart';

const List<Widget> jobs = <Widget>[Text('Doctor'), Text('Nurse')];
final List<bool> _selectedjob = <bool>[true, false];
const List<String> list = <String>['Male', 'Female'];
String dropdownValue = list.first;

String name1 = '';
String email1 = '';
String gender1 = 'Male';
String job1 = 'Doctor';
String phone_number1 = '';
String password1 = '';
String address1 = '';
String Specialization1 = '';
String age1 = '';
int id1 = 0;
bool willAdd = false;
bool isUser = false;

Future<int> addUser() async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request(
      'POST', Uri.parse('http://belalatef.pythonanywhere.com/User/create'));
  request.body = json.encode({
    "email": email1,
    "username": name1,
    "gender": gender1,
    "job": job1,
    "password": password1,
    "phone_number": phone_number1,
    "speciality": Specialization1,
    "age": age1,
    "address": address1,
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();
  final respStr = await response.stream.bytesToString();
  print(respStr);

  if (response.statusCode == 200) {
    print(respStr);
  } else {
    print(response.reasonPhrase);
  }

  name1 = '';
  email1 = '';
  gender1 = 'Male';
  job1 = 'Doctor';
  phone_number1 = '';
  password1 = '';
  address1 = '';
  Specialization1 = '';
  age1 = '';
  id1 = 0;
  willAdd = false;
  return response.statusCode;
}

Future<int> modifyUser() async {
  var headers = {
    'Authorization': 'Bearer $accessToken',
    'Content-Type': 'application/json'
  };
  var request = http.Request(
      'PUT', Uri.parse('http://belalatef.pythonanywhere.com/User/update/$id1'));
  request.body = json.encode({
    "email": email1,
    "username": name1,
    "gender": gender1,
    "job": job1,
    "password": password1,
    "phone_number": phone_number1,
    "age": age1,
    "speciality": Specialization1,
    "address": address1
  });
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  final respStr = await response.stream.bytesToString();
  print(respStr);
  return response.statusCode;
}

class AddModifyUserScreen extends StatelessWidget {
  AddModifyUserScreen(name, email, id, gender, job, phone_number, address,
      password, Specialization, age,
      {isUser1 = false}) {
    name1 = name;
    email1 = email;
    id1 = id;
    gender1 = gender;
    job1 = job;
    phone_number1 = phone_number;
    address1 = address;
    password1 = password;
    Specialization1 = Specialization;
    age1 = age;
    isUser = isUser1;
    print("AddMOD");
    willAdd = name.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AddmodUser(),
    );
  }
}

class AddmodUser extends StatefulWidget {
  const AddmodUser({Key? key}) : super(key: key);

  @override
  State<AddmodUser> createState() => _AddmodUserState();
}

class _AddmodUserState extends State<AddmodUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          decoration: const BoxDecoration(
            color: Color(0xffF2F2F2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  willAdd ? 'Add User' : 'Modify User',
                  style: const TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff383838),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Center(
                child: ToggleButtons(
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < _selectedjob.length; i++) {
                        _selectedjob[i] = i == index;
                      }
                    });
                    index == 0 ? job1 = 'Doctor' : job1 = 'Nurse';
                    print(job1);
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedBorderColor: Color(0xff066163),
                  selectedColor: Color.fromARGB(255, 129, 67, 67),
                  fillColor: Color.fromARGB(200, 49, 204, 211),
                  color: Colors.grey[700],
                  constraints: const BoxConstraints(
                    minHeight: 45.0,
                    minWidth: 100.0,
                  ),
                  isSelected: _selectedjob,
                  children: jobs,
                ),
              ),
              Center(
                child: DropdownButton<String>(
                  value: dropdownValue,
                  elevation: 16,
                  style: const TextStyle(color: Color(0xff066163)),
                  underline: Container(
                    height: 2,
                    color: Color(0xff066163),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                      gender1 = value;
                      print(gender1);
                    });
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: name1.isEmpty
                    ? TextEditingController()
                    : TextEditingController(text: name1),
                onChanged: (value) {
                  name1 = value;
                },
                autofocus: true,
                textAlign: TextAlign.center,
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter name.*'),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: email1.isEmpty
                    ? TextEditingController()
                    : TextEditingController(text: email1),
                onChanged: (value) {
                  email1 = value;
                },
                autofocus: true,
                textAlign: TextAlign.center,
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter email.*'),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  age1 = value;
                },
                autofocus: true,
                textAlign: TextAlign.center,
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter age.'),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: Specialization1.isEmpty
                    ? TextEditingController()
                    : TextEditingController(text: Specialization1),
                onChanged: (value) {
                  Specialization1 = value;
                },
                autofocus: true,
                textAlign: TextAlign.center,
                decoration: kTextFieldDecoration.copyWith(
                    hintText: (job1 == 'Doctor'
                        ? 'Enter Spcialization.'
                        : 'Enter Department.')),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: phone_number1.isEmpty
                    ? TextEditingController()
                    : TextEditingController(text: phone_number1),
                onChanged: (value) {
                  phone_number1 = value;
                },
                autofocus: true,
                textAlign: TextAlign.center,
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter phone number.'),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: password1.isEmpty
                    ? TextEditingController()
                    : TextEditingController(text: password1),
                onChanged: (value) {
                  password1 = value;
                },
                autofocus: true,
                textAlign: TextAlign.center,
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter password.*'),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: address1.isEmpty
                    ? TextEditingController()
                    : TextEditingController(text: address1),
                onChanged: (value) {
                  address1 = value;
                },
                autofocus: true,
                textAlign: TextAlign.center,
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter address.'),
              ),
              const SizedBox(
                height: 20.0,
              ),
              RoundedButton(
                color: const Color(0xff066163),
                onPressed: () async {
                  if (willAdd) {
                    if (email1 != '' &&
                        name1 != '' &&
                        password1 != '' &&
                        job1 != '') {
                      int statusCode = await addUser();

                      if (statusCode == 200) {
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
                                          Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UsersScreen()),
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
                    int statusCode = await modifyUser();
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
                                      if (isUser)
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  else      
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UsersScreen()),
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
                  if (isUser)
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  else      
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UsersScreen()),
                  );
                  }
                },
                title: willAdd ? 'Add User' : 'Modify User',
              ),
              RoundedButton(
                color: const Color(0xff066163),
                onPressed: () {
                  if (isUser)
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  else      
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UsersScreen()),
                  );
                },
                title: 'Cancel',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:icare/components/rounded_button.dart';
import 'package:icare/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:icare/room_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:icare/screens/users_screen.dart';
import '../model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String enteredEmail = '';
  String enteredPassword = '';
  bool showSpinner = false;

  late User data;

  Future<int> _login() async {
    int ret = 0;
    if (enteredEmail.isEmpty || enteredPassword.isEmpty) {
      print('Please enter username and password');
      return 0;
    }

    LoginCredentials credentials =
        LoginCredentials(enteredEmail, enteredPassword);
    var url =
        Uri.parse('https://belalatef.pythonanywhere.com/User/login/token');
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode(credentials.toJson());

    try {
      var response = await http.post(url, headers: headers, body: body);
      ret = response.statusCode;

      if (response.statusCode == 200) {
        // Login successful
        var responseData = json.decode(response.body);
        print(responseData);
        data = User.fromJson(json.decode(response.body)['user']);
      } else {
        // Login failed
        print('Login failed');
      }
    } catch (e) {
      // Error occurred
      print('Error: $e');
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  color: Color.fromARGB(255, 19, 166, 192),
                ),
                ClipOval(
                  child: Container(
                    height: 180,
                    width: 180,
                    color: Color.fromARGB(255, 19, 166, 192),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            ModalProgressHUD(
              inAsyncCall: showSpinner,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                      radius: 90,
                      backgroundImage:
                          AssetImage('assets/icons/ic_launcher.png'),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: Text(
                        'Welcome to Icare Smart System'.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextFormField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              enteredEmail = value;
                            },
                            autofocus: true,
                            decoration: kTextFieldDecoration.copyWith(
                              labelText: 'User/Admin',
                              hintText: 'Enter Your Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          TextFormField(
                            obscureText: true,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              enteredPassword = value;
                            },
                            decoration: kTextFieldDecoration.copyWith(
                              labelText: 'Password',
                              hintText: 'Enter your password.',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24.0,
                          ),
                          RoundedButton(
                            color: const Color.fromARGB(255, 19, 166, 192),
                            onPressed: () async {
                              {
                                if (enteredEmail == 'admin' &&
                                    enteredPassword == 'admin') {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UsersScreen()));
                                } else {
                                  if (enteredEmail != '' &&
                                      enteredPassword != '') {
                                    int statusCode = await _login();
                                    if (statusCode == 200) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => roomScreen(
                                                    user1: data,
                                                  )));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          duration:
                                              Duration(milliseconds: 2000),
                                          content: Text(
                                            'Logined Successfully !',
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
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          duration:
                                              Duration(milliseconds: 2000),
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
                                }
                              }
                            },
                            title: 'Log In',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

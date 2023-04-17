import 'package:icare/components/rounded_button.dart';
import 'constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:icare/screens/users_screen.dart';

import 'package:icare/editedoctor.dart';
import 'package:icare/home.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String enteredUserName = '';
  String enteredPassword = '';
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xffF2F2F2),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Stack(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  color: Color.fromARGB(255, 21, 186, 217),
                ),
                ClipOval(
// clipper: MyClipper(),
                  child: Container(
                    height: 180,
                    width: 180,
                    color: Color.fromARGB(255, 21, 186, 217),
                  ),
                ),
              ],
            ),
          ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.stretch,

                children: <Widget>[
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage('assets/images/doctor.png'),
                  ),
                  Container(
                  child: Text(
                    'Welcome',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                  const SizedBox(
                    height: 48.0,
                  ),


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextFormField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            enteredUserName = value;
                          },
                          decoration: kTextFieldDecoration.copyWith(
                                                  labelText: 'Email',
                            hintText: 'Enter your Username',
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
                    color: const Color.fromARGB(1000, 21, 186, 217),
                    onPressed: () {
                      if (enteredPassword == 'admin' &&
                          enteredUserName == 'admin') {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => UsersScreen()));
                      } else {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyHome()));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(milliseconds: 2000),
                            content: Text(
                              'Invalid Details!',
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                            ),
                            backgroundColor: Color(0xffCDBE78),
                          ),
                        );
                      }
                    },
                    title: 'Log In',
                  )
                      
                     ,Container(
                  width: 200,
                  child: IconButton(
                      onPressed: () {},
                      icon: Text(
                        'forget password?',
                        style: TextStyle(color: Colors.blue),
                      )),
                ),
                OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditeDoctor()));
                    },
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    child: const Text('Register',style: TextStyle(color: Color.fromARGB(1000, 21, 186, 217)),))
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, sort_child_properties_last

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icare/editedoctor.dart';
import 'package:icare/home.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
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
                  height: 100,
                  width: 100,
                  color: Color.fromARGB(255, 21, 186, 217),
                ),
                ClipOval(
// clipper: MyClipper(),
                  child: Container(
                    height: 200,
                    width: 200,
                    color: Color.fromARGB(255, 21, 186, 217),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('assets/dector.png'),
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
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      
                      labelText: 'Password',
                      border: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 250,
                  height: 50,
                  decoration: BoxDecoration(
                    
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyHome()));
                      },
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(Color.fromARGB(255,49,204,211))),),
                ),
                Container(
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
            )
          ],
        ),
      ),
    );
  }
}

// class MyClipper extends CustomClipper<Rect>{
//   @override
//   Rect getClip(Size size) {
// return Rect.fromLTRB(150, 150, 50,50);


//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Rect> oldClipper) =>false;

// }

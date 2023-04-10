

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicen/editedoctor.dart';
import 'package:medicen/home.dart';

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
                  height: 120,
                  width: 120,
                  color: Colors.blue,

                ),
                ClipOval(
// clipper: MyClipper(),
                  child: Container(

                    height: 200,
width: 200,
color: Colors.blue,
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
          child: Text('Welcome',style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
            decoration: InputDecoration(

              labelText: 'Username',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
            decoration: InputDecoration(

              labelText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
        SizedBox(height: 30,),
        Container(
          width: 250,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          child: ElevatedButton(
              onPressed: (){         Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHome()));
              }, child:Text('LOGIN',style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20),)),
        ),

        Container(
          width: 200,
          child: IconButton(

              onPressed: (){}, icon: Text('forget password?',style: TextStyle(color: Colors.blue),)),
        ),

        OutlinedButton(onPressed: (){
         Navigator.push(context, MaterialPageRoute(builder: (context)=>EditeDoctor()));
        },
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  vertical: 10,horizontal: 10,
                ),textStyle: TextStyle(
              fontWeight:FontWeight.bold,
              fontSize: 20,

            )
            ),


            child:const Text('Register'))
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
//
//
//   }
//
//   @override
//   bool shouldReclip(covariant CustomClipper<Rect> oldClipper) =>false;
//
// }

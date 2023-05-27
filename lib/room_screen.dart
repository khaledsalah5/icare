import 'package:flutter/material.dart';
import 'package:icare/bed_screen.dart';
import 'package:icare/pages/main_page.dart';
import 'package:icare/screens/add_modify_user_screen.dart';
import 'model.dart';

late User user;

class roomScreen extends StatefulWidget {
  roomScreen({required user1}) {
    user = user1;
  }

  @override
  State<roomScreen> createState() => _roomScreenState();
}

class _roomScreenState extends State<roomScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xb3e5dfdf),
        appBar: AppBar(
          title: Text('Intensive Care Room'),
        ),
        drawer: Container(
          color: Color.fromARGB(255, 21, 186, 217),
          child: Drawer(
            width: double.infinity,
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  currentAccountPicture: IconButton(
                    onPressed: () {},
                    icon: CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage('assets/nurs.png'),
                    ),
                  ),
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
        ),
        body: Column(
          children: [

            GestureDetector(child: PatientWidget(),onTap: (){
              Navigator.push(context,MaterialPageRoute(builder:(context) { return bedScreen1();}  ));
            },),
          ],
        ),
      ),
    );
  }
}

class PatientWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xff5faceb), // added this line
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Patient's Name :",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text("Patient ID:", style: TextStyle(fontSize: 16)),
              Spacer(),
              Text("Age:", style: TextStyle(fontSize: 16)),
              Spacer(),
              Text("Gender:", style: TextStyle(fontSize: 16)),
              Spacer(),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text("SBP:", style: TextStyle(fontSize: 16)),
              Spacer(),
              Text("Temp:", style: TextStyle(fontSize: 16)),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}

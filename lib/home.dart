
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icare/note.dart';
import 'package:icare/pages/main_page.dart';
import 'package:icare/room2.dart';

import 'admin_panel.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
  
  void onStartButtonPressed() {}
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Room2()));
      },
        child: Icon(Icons.add,color: Colors.blue,),

      ),
      backgroundColor: Colors.blue,
     appBar: AppBar(
elevation: 0,
     ),
      drawer: Container(
        color: Color.fromARGB(255, 21, 186, 217),
        child: Drawer(
          width: double.infinity,
          child: Column(

            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture:   IconButton(
                  onPressed: (){

                  },
                  icon: CircleAvatar(
                    radius: 100,
                    backgroundImage:AssetImage('assets/nurs.png') ,

                  ),
                ),
                accountName: Text('User Name'),
                accountEmail: Text('mj5069945@gmail.com') ,

              ),
              ListTile(
                title: Text('الملف الشخصي'),leading: Icon(Icons.person),onTap: (){

              },






              ),

              ListTile(
                title: Text('Birthday'),leading: Icon(Icons.date_range),onTap: (){
                //  navigateTo(context, TwittersettingScreen());
              },







              ),
              ListTile(
                title: Text('Phone'),leading: Icon(Icons.phone),onTap: (){

              },







              ),

              ListTile(
                title: Text('Edit Password'),leading: Icon(Icons.lock),onTap: (){
                
                //  navigateTo(context, TwittersettingScreen());
              },

              ),
              ListTile(
                title: Text('Edit profile'),leading: Icon(Icons.edit),onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminPanel()));
              },
              ),
              ListTile(
                title: Text('Note'),leading: Icon(Icons.person),onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage()));
              },






              ),

            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          children:  [
            SizedBox(height: 25,),
            Container(
                width: 180,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Image(image: AssetImage('assets/room1.png'),fit: BoxFit.fill,)),
            Text('room1',style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(height: 25,),
            Container(
                width: 180,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Image(image: AssetImage('assets/room1.png'),fit: BoxFit.fill,)),
            Text('room2',style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(height: 25,),
            Container(
                width: 180,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Image(image: AssetImage('assets/room1.png'),fit: BoxFit.fill,)),
            Text('room3',style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),),








          ],
        ),
      ),
    );
  }
}

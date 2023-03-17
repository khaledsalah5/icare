
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(height: 150,),
          Text('Admin Panel',style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),),
          SizedBox(height: 50,),
          Container(
            width: 300,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),

            child: IconButton(onPressed: (){}, icon: Text('add new user ',style: TextStyle(
                color: Colors.black
            ),)),
          ),
          SizedBox(height: 50,),
          Container(
            width: 300,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),

            child: IconButton(onPressed: (){}, icon: Text('add new user ',style: TextStyle(
                color: Colors.black
            ),)),
          )
        ],
      ),
    );
  }
}

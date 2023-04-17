//import 'package:flutter/cupertino.dart';
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
      //backgroundColor: Colors.blue,
      appBar: AppBar(backgroundColor: Color.fromARGB(1000, 21, 186, 217),centerTitle: true,title: Text("I care"),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(height: 150,),
          Text('Admin Panel',style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),),
          SizedBox(height: 100,),
          Container(
            width: 300,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[400],
            ),

            child: IconButton(onPressed: (){}, icon: Text('Add New User',style: TextStyle(fontSize: 20,
                color: Colors.black
            ),)),
          ),
          SizedBox(height: 50,),
          Container(
            width: 300,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[400],
              
            ),

            child: IconButton(onPressed: (){}, icon: Text('Edit Current User ',style: TextStyle(fontSize: 20,
                color: Colors.black
            ),)),
          )
        ],
      ),
    );
  }
}

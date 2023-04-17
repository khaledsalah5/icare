//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Room2 extends StatefulWidget {
  const Room2({Key? key}) : super(key: key);

  @override
  State<Room2> createState() => _Room2State();
}

class _Room2State extends State<Room2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        elevation: 0,
        actions: [
         Padding(
           padding: const EdgeInsets.all(10.0),
           child: CircleAvatar(
             radius: 25,
             backgroundColor: Colors.greenAccent,
             child: Text('k'),
           ),
         )
        ],
      ),

      body: Center(
        child: Column(
          children:  [
            SizedBox(height: 25,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 52,),
            CircleAvatar(
              child:Container(
                color: Colors.white,
              ),
            ),
            SizedBox(width: 15,),
            Container(
                width: 180,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Image(image: AssetImage('assets/room1.png'),fit: BoxFit.fill,)),

          ],
        ),
            Text('room1',style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(height: 25,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 52,),
                CircleAvatar(
                  child:Container(
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 15,),
                Container(
                    width: 180,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Image(image: AssetImage('assets/room1.png'),fit: BoxFit.fill,)),

              ],
            ),
            Text('room2',style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(height: 25,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 52,),
                CircleAvatar(
                  child:Container(
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 15,),
                Container(
                    width: 180,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Image(image: AssetImage('assets/room1.png'),fit: BoxFit.fill,)),

              ],
            ),
            Text('room3',style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(height: 25,),
           Container(
             width: 150,
               color: Colors.white,

               child: IconButton(onPressed: (){}, icon: Text('LOGIN')))








          ],
        ),
      ),
    );
  }
}

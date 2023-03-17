

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Note extends StatefulWidget {
  const Note({Key? key}) : super(key: key);

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
      ),
      body: Column(
        children: [
          Container(height: 150,),
          Center(
            child: Container(
              child: Text(
                  'Notes',style: TextStyle(fontSize: 30),
              ),
            ),
          ),
          Container(height: 20,),
          Container(
            child: Text(
                'this a   example for a note in ICU System',style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      )
    );
  }
}

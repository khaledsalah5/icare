import 'package:flutter/material.dart';
import 'editor_page.dart';
import 'note_mini.dart';
import 'package:page_transition/page_transition.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final _notesBox = Hive.box('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text(
          'Notes',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 21, 186, 217),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx < 1500.0) {
            Navigator.push(
              context,
              PageTransition(
                alignment: Alignment.bottomCenter,
                curve: Curves.easeInOut,
                duration: Duration(milliseconds: 600),
                reverseDuration: Duration(milliseconds: 600),
                type: PageTransitionType.rightToLeftJoined,
                child: EditorPage(noteKey: 0, content: '', title: ''),
                childCurrent: this.widget,
                settings: const RouteSettings(name: '/editor'),
              ),
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: GridView.count(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      alignment: Alignment.bottomCenter,
                      curve: Curves.easeInOut,
                      duration: Duration(milliseconds: 600),
                      reverseDuration: Duration(milliseconds: 600),
                      type: PageTransitionType.rightToLeftJoined,
                      child: EditorPage(noteKey: 0, content: '', title: ''),
                      childCurrent: this.widget,
                      settings: const RouteSettings(name: '/editor'),
                    ),
                  );
                },
                child: Hero(
                  tag: 'add_note_button',
                  child: Material(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    elevation: 2,
                    shadowColor: Color.fromARGB(255, 147, 132, 87),
                    child: Container(
                      width: 10,
                      height: 150,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(54, 158, 158, 158),
                        border: Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Color.fromARGB(255, 49, 204, 211),
                        size: 50,
                        shadows: [
                          Shadow(color: Colors.black, offset: Offset(1, 1))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              for (int key in _notesBox.keys)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        alignment: Alignment.bottomCenter,
                        curve: Curves.easeInOut,
                        duration: Duration(milliseconds: 600),
                        reverseDuration: Duration(milliseconds: 600),
                        type: PageTransitionType.rightToLeftJoined,
                        child: EditorPage(
                          noteKey: key,
                          content: _notesBox.get(key)[1],
                          title: _notesBox.get(key)[0],
                        ),
                        childCurrent: this.widget,
                        settings: RouteSettings(name: '/editor/$key'),
                      ),
                    );
                  },
                  child: Hero(
                    tag: 'note_mini_$key',
                    child: Material(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      elevation: 2,
                      shadowColor: Color.fromARGB(255, 14, 118, 136),
                      child: NoteMini(
                        title: _notesBox.get(key)[0],
                        content: _notesBox.get(key)[1],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
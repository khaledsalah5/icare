import 'package:flutter/material.dart';
//import 'package:medicen/home.dart';
import 'package:icare/myLogin.dart';
//import 'admin_panel.dart';

//import 'pages/welcome_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
//import 'pages/main_page.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  var box = await Hive.openBox('notes');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      theme: ThemeData(


        primarySwatch: Colors.blue,
      ),
      home: const MyLogin(),
    );
  }
}


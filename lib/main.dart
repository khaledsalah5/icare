import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:icare/bed_screen.dart';
import 'package:icare/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
// ignore: unused_local_variable
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
      theme: ThemeData(),
      home:LoginScreen(),

    );
  }
}

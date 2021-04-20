import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:store_admin/screens/login/login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.pinkAccent,

      ),
      home: LoginScreen(),
    );
  }
}


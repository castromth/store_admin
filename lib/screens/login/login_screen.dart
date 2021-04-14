import 'package:flutter/material.dart';
import 'package:store_admin/screens/login/widgets/form_container.dart';
import 'package:store_admin/screens/login/widgets/signin_button.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 300,
              width: 300,
              child: Icon(Icons.store_mall_directory , size: 160,color: Colors.pinkAccent,)),
            FormContainer(),
            SignInButton(),
          ],
            ),
        ),
      ),
    );
  }
}

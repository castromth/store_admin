import 'package:flutter/material.dart';
import 'package:store_admin/screens/login/widgets/form_container.dart';
import 'package:store_admin/screens/login/widgets/signin_button.dart';


class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black87
        ),
        child: ListView(
          children: [Column(
            children: [
              Container(
                height: 300,
                width: 300,
                child: Icon(Icons.business , size: 120,color: Colors.pinkAccent,)),
              FormContainer(),
              SignInButton(),
            ],
          )],
        ),
      ),
    );
  }
}

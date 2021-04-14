import 'package:flutter/material.dart';


class SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.pinkAccent, minimumSize: Size(100,50)),
        onPressed: (){
        },
        child: Text("Entrar" , style: TextStyle(color: Colors.white),),
      ),
    );
  }
}

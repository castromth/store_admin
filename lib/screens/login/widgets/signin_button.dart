import 'package:flutter/material.dart';


class SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {},
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.pinkAccent
          ),
          child: Text(
            "Entra",
            style: TextStyle(fontWeight: FontWeight.w300, color: Colors.white, letterSpacing: 0.2),
          ),
        ),
      ),
    );
  }
}

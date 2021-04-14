import 'package:flutter/material.dart';



class InputField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final bool obscure;

  InputField({@required this.icon,@required this.hint, @required this.obscure});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        obscureText: obscure,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          icon: Icon(icon, color: Colors.white),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white, fontSize: 15),
          contentPadding: EdgeInsets.only(top:30,right: 30,bottom: 30,left: 5)
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';



class InputField extends StatelessWidget {
  final IconData icon;
  final String hint;
  final bool obscure;
  final Stream<String> stream;
  final Function(String) onChaged;


  InputField({@required this.icon,@required this.hint, @required this.obscure, @required this.stream, @required this.onChaged});


  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<String>(
        stream: stream,
        builder: (context, snapshot) {
          return TextFormField(
            onChanged: onChaged,
            obscureText: obscure,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              errorText: snapshot.hasError ? snapshot.error : null,
              icon: Icon(icon, color: Colors.white),
              hintText: hint,
              hintStyle: TextStyle(color: Colors.white, fontSize: 15),
              contentPadding: EdgeInsets.only(top:30,right: 30,bottom: 30,left: 5)
            ),
          );
        }
      ),
    );
  }
}

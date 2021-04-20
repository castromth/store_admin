import 'package:flutter/material.dart';
import 'package:store_admin/screens/login/blocs/login_bloc.dart';

class SignInButton extends StatelessWidget {
  final LoginBloc loginBloc;

  SignInButton({@required this.loginBloc});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: loginBloc.onSubmitValid,
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: ElevatedButton(
              style: snapshot.hasData
                  ? ElevatedButton.styleFrom(
                      primary: Colors.pinkAccent, minimumSize: Size(100, 50))
                  : ElevatedButton.styleFrom(
                      minimumSize: Size(100, 50),
                      onSurface: Colors.pinkAccent),
              onPressed: snapshot.hasData ? loginBloc.submit : null,
              child: Text(
                "Entrar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        });
  }
}

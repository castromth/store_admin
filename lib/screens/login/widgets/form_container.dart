import 'package:flutter/material.dart';
import 'package:store_admin/screens/login/blocs/login_bloc.dart';

import 'input_field.dart';

class FormContainer extends StatelessWidget {

  final LoginBloc loginBloc;

  FormContainer({@required this.loginBloc});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        child: Column(
          children: [
            InputField(
              hint: "Usuario",
              icon: Icons.person_outline,
              obscure: false,
              stream: loginBloc.outEmail,
              onChaged: loginBloc.changeEmail,

            ),
            InputField(
                icon: Icons.lock_outline,
                hint: "Senha",
                stream: loginBloc.outPassword,
                onChaged: loginBloc.changePassword,
                obscure: true)
          ],
        ),
      ),
    );
  }
}

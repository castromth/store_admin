import 'package:flutter/material.dart';

import 'input_field.dart';

class FormContainer extends StatelessWidget {
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
            ),
            InputField(
                icon: Icons.lock_outline,
                hint: "Senha",
                obscure: true)
          ],
        ),
      ),
    );
  }
}

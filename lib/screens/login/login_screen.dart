import 'package:flutter/material.dart';
import 'package:store_admin/screens/home/home_screen.dart';
import 'package:store_admin/screens/login/blocs/login_bloc.dart';
import 'package:store_admin/screens/login/widgets/form_container.dart';
import 'package:store_admin/screens/login/widgets/signin_button.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {



  final _loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: StreamBuilder<LoginState>(
        stream: _loginBloc.outState,
        initialData: LoginState.LOADING,
        builder: (context, snapshot) {
          switch(snapshot.data){
            case LoginState.LOADING:
              return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.pinkAccent)));
            case LoginState.FAIL:
            case LoginState.SUCCESS:
            case LoginState.IDLE:
            return Stack(
              alignment: Alignment.center,
              children: [
                Container(),
                SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                            child: Icon(Icons.store_mall_directory , size: 160,color: Colors.pinkAccent,)),
                        FormContainer(loginBloc: _loginBloc),
                        SignInButton(loginBloc: _loginBloc),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return Container();
        }
      ),
    );
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();

  }

  @override
  void initState() {
    super.initState();
    _loginBloc.outState.listen((state) {
      switch(state){
        case LoginState.SUCCESS:
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
          break;
        case LoginState.FAIL:
          showDialog(context: context, builder: (context) => AlertDialog(
            title: Text("Erro"),
            content: Text("Você não tem os privilegios necessarios"),
          ));
          break;
          
      }
    });
  }
}

import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:store_admin/screens/login/validaors/login_validators.dart';


enum LoginState{IDLE, LOADING, SUCCESS, FAIL}

class LoginBloc extends BlocBase with LoginValidators {


  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<LoginState>();

  Stream<LoginState> get outState => _stateController.stream;
  Stream<String> get outEmail => _emailController.stream.transform(validadeEmail);
  Stream<String> get outPassword => _passwordController.stream.transform(validadePassword);

  Stream<bool> get onSubmitValid => Observable.combineLatest2(outEmail, outPassword, (a, b) => true);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  StreamSubscription _streamSubscription;

  LoginBloc(){
    _streamSubscription = FirebaseAuth.instance.authStateChanges().listen((user) async {
      if(user != null){
        if(await verifyPrivileges(user)){
          _stateController.add(LoginState.SUCCESS);
        }else {
          FirebaseAuth.instance.signOut();
          _stateController.add(LoginState.FAIL);
        }
      }else{
        _stateController.add(LoginState.IDLE);
      }
    });
  }
  void submit(){
    final email = _emailController.value;
    final password = _passwordController.value;
    _stateController.add(LoginState.LOADING);
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).catchError((e) {
      print(e);
      _stateController.add(LoginState.FAIL);
    });
  }

  Future<bool> verifyPrivileges(User user) async{
    return await FirebaseFirestore.instance.collection("admins").doc(user.uid).get().then((value) {
      print(value.data());
      if(value.data() != null){
        return true;
      }else {
        return false;
      }
    }).catchError((e) {
      return false;
    });
  }
  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
    _stateController.close();
    _streamSubscription.cancel();
  }
}
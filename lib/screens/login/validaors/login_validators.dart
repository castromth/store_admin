import 'dart:async';

class LoginValidators {

  final validadeEmail = StreamTransformer<String, String>.fromHandlers( handleData: (email, sink){
    if(email.contains("@")){
      sink.add(email);
    }else{
      sink.addError("Insira um e-mail válido");
    }
  });


  final validadePassword = StreamTransformer<String, String>.fromHandlers(handleData: (password, sink){
    if(password.length >= 8){
      sink.add(password);
    }else{
      sink.addError("Insira um senha válida");
    }
  });


}
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/subjects.dart';



class UserBloc extends BlocBase {

  final _usersController = BehaviorSubject<List>();

  Map<String, Map<String, dynamic>> _users = {};

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List> get outUsers => _usersController.stream;

  UserBloc(){
    _addUsersListener();
  }
  void _addUsersListener(){
    _firestore.collection("users").snapshots().listen((snapshot) {
      snapshot.docChanges.forEach((element) {
        String uid = element.doc.id;
        switch(element.type){
          case DocumentChangeType.added:
            _users[uid] = element.doc.data();
            _subscribeToOrders(uid);
            break;
          case DocumentChangeType.modified:
            _users[uid].addAll(element.doc.data());
            _usersController.add(_users.values.toList());
            break;
          case DocumentChangeType.removed:
            _unsubscribeToOrders(uid);
            _users.remove(uid);
            _usersController.add(_users.values.toList());
            break;
        }
      });
    });
  }

  void _subscribeToOrders(String uid)  {
    _users[uid]["subscription"] = _firestore.collection("users").doc(uid).collection("orders").snapshots().listen((orders) async {
      int numOrders = orders.docs.length;
      double money = 0.0;
      for(DocumentSnapshot d in orders.docs){
        DocumentSnapshot order = await _firestore.collection("orders").doc(d.id).get();
        if(order.data() != null)
          money += order.data()["totalPrice"];
      }

      _users[uid].addAll({
        "money": money, "orders": numOrders
      });

      _usersController.add(_users.values.toList());
    });
  }

  void _unsubscribeToOrders(String uid){
    _users[uid]["subscription"].cancel();
  }

  void onChangedSearch(String search){
    if(search.trim().isEmpty){
      _usersController.add(_users.values.toList());
    }else {
      _usersController.add(_filter(search.trim()));
    }
  }

  List<Map<String, dynamic>> _filter(String search){
    List<Map<String, dynamic>> filteredUsers = List.from(_users.values.toList());
    filteredUsers.retainWhere((user) {
      return user["name"].toUpperCase().contains(search.toUpperCase());
    });
    return filteredUsers;
  }

  Map<String, dynamic> getUser(String uid){
    return _users[uid];
  }

  @override
  void dispose() {
    _usersController.close();
  }


}
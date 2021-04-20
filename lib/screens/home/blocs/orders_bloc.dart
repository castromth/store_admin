import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';


class OrdersBloc extends BlocBase{

  final _ordersController = BehaviorSubject<List>();
  List<DocumentSnapshot> _orders = [];

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List> get outOrders => _ordersController.stream;


  OrdersBloc(){
    _addOrdersListener();
  }

  void _addOrdersListener(){
    _firestore.collection("orders").snapshots().listen((snapshot) {
      snapshot.docChanges.forEach((element) {
        String uid = element.doc.id;
        switch(element.type){
          case DocumentChangeType.added:
            _orders.add(element.doc);
            break;
          case DocumentChangeType.modified:
            _orders.removeWhere((element) => element.id == uid);
            _orders.add(element.doc);
            break;
          case DocumentChangeType.removed:
            _orders.removeWhere((element) => element.id == uid);
            break;
        }
      });
      _ordersController.add(_orders);
    });
  }
  @override
  void dispose() {
    _ordersController.close();
  }
}
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

enum SortCriteria {READY_FIRST, READY_LAST}
class OrdersBloc extends BlocBase{

  final _ordersController = BehaviorSubject<List>();
  List<DocumentSnapshot> _orders = [];

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List> get outOrders => _ordersController.stream;

  SortCriteria _criteria;


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
      _sort();
    });
  }

  void setOrderCriteria(SortCriteria criteria){
    _criteria = criteria;
    _sort();
  }

  void _sort(){
    switch(_criteria){
      case SortCriteria.READY_FIRST:
        _orders.sort((a,b){
          int sa = a.data()["status"];
          int sb = b.data()["status"];
          if(sa < sb) return 1;
          else if (sb > sa) return -1;
          else return 0;
        });
        break;
      case SortCriteria.READY_LAST:
        _orders.sort((a,b){
          int sa = a.data()["status"];
          int sb = b.data()["status"];
          if(sa > sb) return 1;
          else if (sb < sa) return -1;
          else return 0;
        });
        break;

    }
    _ordersController.add(_orders);
  }
  @override
  void dispose() {
    _ordersController.close();
  }
}
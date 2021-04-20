import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_admin/screens/home/blocs/user_bloc.dart';

class OrderHeader extends StatelessWidget {

  final DocumentSnapshot order;

  OrderHeader({@required this.order});
  @override
  Widget build(BuildContext context) {

    final _userBloc = BlocProvider.getBloc<UserBloc>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${_userBloc.getUser(order.data()["clientId"])["name"]}"),
            Text("${_userBloc.getUser(order.data()["clientId"])["address"]}")
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("Preço Produtos:R\$${order.data()["productsPrice"].toStringAsFixed(2)}",style: TextStyle(fontWeight: FontWeight.w500),),
            Text("Preço total:R\$${order.data()["totalPrice"].toStringAsFixed(2)}",style: TextStyle(fontWeight: FontWeight.w500))
          ],
        )
      ],
    );
  }
}

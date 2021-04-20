import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'order_header.dart';

class OrderTile extends StatelessWidget {
  final DocumentSnapshot order;
  final states = [
    "",
    "Em preparação",
    "Em transporte",
    "Aguardando Entrega",
    "Entregue"
  ];
  OrderTile({@required this.order});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Card(
        child: ExpansionTile(
          key: Key(order.id),
          title: Text(
            "${order.id.substring(order.id.length - 7, order.id.length)} - ${states[order.data()["status"]]}",
            style: TextStyle(color: order["status"] != 4 ? Colors.grey[850] : Colors.green),
          ),
          children: [
            Padding(
              padding:
                  EdgeInsets.only(right: 16, left: 16.0, bottom: 8.0, top: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OrderHeader(order: order),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: order.data()["products"].map<Widget>((p) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(p["product"]["title"]+ " - "+p["size"]),
                        subtitle: Text(p["category"] + "/" + p["pid"]),
                        trailing: Text(p["quantity"].toString()),
                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            order.reference.delete();
                            FirebaseFirestore.instance.collection("users").doc(order["clientId"]).collection("orders").doc(order.id).delete();
                          },
                          child: Text("Excluir",
                              style: TextStyle(color: Colors.red))),
                      TextButton(
                          onPressed: order.data()["status"] > 1 ?() {
                            order.reference.update({"status": order.data()["status"] -1 });
                          } : null,
                          child: Text("Regredir",
                              style: TextStyle(color: Colors.grey[850]))),
                      TextButton(
                          onPressed:order.data()["status"] < 4 ? () {
                            order.reference.update({"status": order.data()["status"] +1 });
                          } : null,
                          child: Text("Avançar",
                              style: TextStyle(color: Colors.green)))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

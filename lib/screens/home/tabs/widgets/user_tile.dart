import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UsersTile extends StatelessWidget {
  final Map<String, dynamic> user;

  UsersTile({@required this.user});

  @override
  Widget build(BuildContext context) {
    if (user.containsKey("money")) {
      return ListTile(
        title: Text(
          user["name"],
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(user["email"], style: TextStyle(color: Colors.white)),
        trailing: Column(
          children: [
            Text(
              "Pedidos: ${user["orders"]}",
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "Gastos: R\$${user["money"].toStringAsFixed(2)}",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 200,
              height: 20,
              child: Shimmer.fromColors(
                  child: Container(
                    color: Colors.white.withAlpha(50),
                    margin: EdgeInsets.symmetric(vertical: 4)
                  ),
                  baseColor: Colors.white,
                  highlightColor: Colors.grey),
            ),
            SizedBox(
              width: 50,
              height: 20,
              child: Shimmer.fromColors(
                  child: Container(
                      color: Colors.white.withAlpha(50),
                      margin: EdgeInsets.symmetric(vertical: 4)
                  ),
                  baseColor: Colors.white,
                  highlightColor: Colors.grey),
            )
          ],
        ),
      );
    }
  }
}

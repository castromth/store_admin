import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:store_admin/screens/home/tabs/widgets/edit_categoryDialog.dart';
import 'package:store_admin/screens/product/product_screen.dart';

class CategoryTile extends StatelessWidget {
  DocumentSnapshot category;

  CategoryTile({@required this.category});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Card(
        child: ExpansionTile(
          leading: GestureDetector(
            onTap: (){
              showDialog(context: context, builder: (context) => EditCategoryDialog(category: category,));
            },
            child: CircleAvatar(
                backgroundImage: NetworkImage(category.data()["icon"]),
                backgroundColor: Colors.transparent),
          ),
          title: Text(category.data()["title"],
              style:
                  TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: category.reference.collection("items").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Container();
                return Column(
                  children: snapshot.data.docs
                      .map((doc) => ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  NetworkImage(doc.data()["images"][0]),
                            ),
                            title: Text(doc.data()["title"]),
                            trailing: Text(
                                "R\$${doc.data()["price"].toStringAsFixed(2)}"),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ProductScreen(categoryid: category.id, product: doc)));
                            },
                          ))
                      .toList()
                        ..add(ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              Icons.add,
                              color: Colors.pinkAccent,
                            ),
                          ),
                          title: Text("Adicionar"),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProductScreen(
                                      categoryid: category.id,
                                    )));
                          },
                        )),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

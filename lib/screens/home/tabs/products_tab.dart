import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:store_admin/screens/home/tabs/widgets/category_tile.dart';



class ProductsTab extends StatefulWidget {
  @override
  _ProductsTabState createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("products").snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData) return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white)));
        return ListView.builder(
            itemBuilder: (context, index){
              return CategoryTile(category: snapshot.data.docs[index]);
            },
            itemCount: snapshot.data.docs.length);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

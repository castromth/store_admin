import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:store_admin/screens/product/bloc/product_bloc.dart';
import 'package:store_admin/screens/product/validators/product_validador.dart';
import 'package:store_admin/screens/product/widgets/images_widget.dart';

class ProductScreen extends StatefulWidget {
  final String categoryid;
  final DocumentSnapshot product;

  ProductScreen({this.categoryid, this.product});

  @override
  _ProductScreenState createState() => _ProductScreenState(categoryid, product);
}

class _ProductScreenState extends State<ProductScreen> with ProductValidator {
  final ProcuctBloc _procuctBloc;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  _ProductScreenState(String categoryId, DocumentSnapshot product)
      : _procuctBloc = ProcuctBloc(product: product, categoryid: categoryId);

  @override
  Widget build(BuildContext context) {
    final _fieldStyle = TextStyle(color: Colors.white, fontSize: 16);
    InputDecoration _buildDecoration(String label) {
      return InputDecoration(
          labelStyle: TextStyle(color: Colors.grey), labelText: label);
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        elevation: 0,
        title: StreamBuilder<bool>(
            stream: _procuctBloc.outCreated,
            initialData: false,
            builder: (context, snapshot) {
              return Text(
                  snapshot.hasData ? "Editar Produto" : "Criar Produto");
            }),
        actions: [
          StreamBuilder<bool>(
            stream: _procuctBloc.outCreated,
            initialData: false,
            builder: (context, snapshot) {
              if (snapshot.data)
                return StreamBuilder<bool>(
                    stream: _procuctBloc.outLoading,
                    builder: (context, snapshot) {
                      return IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: snapshot.hasData
                              ? null
                              : () {
                                  _procuctBloc.deleteProduct();
                                  Navigator.of(context).pop();
                                });
                    });
              else
                return Container();
            },
          ),
          StreamBuilder<bool>(
              stream: _procuctBloc.outLoading,
              initialData: false,
              builder: (context, snapshot) {
                return IconButton(
                    icon: Icon(Icons.save),
                    onPressed: snapshot.data ? null : saveProduct);
              })
        ],
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: StreamBuilder<Map>(
                stream: _procuctBloc.outData,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Container();
                  return ListView(
                    padding: EdgeInsets.all(16),
                    children: [
                      Text("Images",
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ImagesWidget(
                        context: context,
                        initialValue: snapshot.data["images"],
                        onSaved: _procuctBloc.saveImages,
                        validator: validadeImages,
                      ),
                      TextFormField(
                        initialValue: snapshot.data["title"],
                        style: _fieldStyle,
                        decoration: _buildDecoration("Titulo"),
                        onSaved: _procuctBloc.saveTitle,
                        validator: validateTitle,
                      ),
                      TextFormField(
                        initialValue: snapshot.data["marca"],
                        style: _fieldStyle,
                        decoration: _buildDecoration("Marca"),
                        onSaved: _procuctBloc.saveMarca,
                        validator: validadeMarca,
                      ),
                      TextFormField(
                        initialValue:
                            snapshot.data["price"]?.toStringAsFixed(2),
                        style: _fieldStyle,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration: _buildDecoration("Preço"),
                        onSaved: _procuctBloc.savePrice,
                        validator: validadePrice,
                      )
                    ],
                  );
                }),
          ),
          StreamBuilder<bool>(
            stream: _procuctBloc.outLoading,
            initialData: false,
            builder: (context, snapshot) {
              return IgnorePointer(
                ignoring: !snapshot.data,
                child: Container(
                  color: snapshot.data ? Colors.black54 : Colors.transparent,
                ),
              );
            },
          )
        ],
      ),
    );
  }

  void saveProduct() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: SizedBox(
            height: 15,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Salvando produto",
                    style: TextStyle(color: Colors.white)),
                Container(
                    height: 20,
                    width: 20,
                    padding: EdgeInsets.only(left: 4),
                    child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.pinkAccent)))
              ],
            ),
          ),
          duration: Duration(minutes: 1)));

      bool sucess = await _procuctBloc.saveProduct();
      ScaffoldMessenger.of(context).removeCurrentSnackBar();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              sucess ? "Produto salvo com sucesso" : "Erro ao salvar produto",
              style: TextStyle(color: Colors.white)),
          duration: Duration(minutes: 1)));

      ScaffoldMessenger.of(context).removeCurrentSnackBar();
    }
  }
}

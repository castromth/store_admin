import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';

class ProcuctBloc extends BlocBase {
  String categoryid;
  DocumentSnapshot product;

  Map<String, dynamic> unsavedData = {};

  final _dataController = BehaviorSubject<Map>();

  final _loadController = BehaviorSubject<bool>();

  final _createdController = BehaviorSubject<bool>();

  Stream<bool> get outCreated => _createdController.stream;
  Stream<Map> get outData => _dataController.stream;
  Stream<bool> get outLoading => _loadController.stream;

  ProcuctBloc({this.categoryid, this.product}) {
    if (product != null) {
      unsavedData = Map.of(product.data());
      unsavedData["images"] = List.of(product.data()["images"]);
      unsavedData["sizes"] = List.of(product.data()["sizes"]);

      _createdController.add(true);
    } else {
      unsavedData = {
        "title": null,
        "marca": null,
        "price": null,
        "images": [],
        "sizes": []
      };
      _createdController.add(false);
    }

    _dataController.add(unsavedData);
  }

  void saveTitle(String title) {
    unsavedData["title"] = title;
  }

  void saveMarca(String marca) {
    unsavedData["marca"] = marca;
  }

  void savePrice(String price) {
    unsavedData["price"] = double.parse(price);
  }

  void saveImages(List images) {
    unsavedData["images"] = images;
  }

  Future<bool> saveProduct() async {
    _loadController.add(true);
    try {
      if (product != null) {
        await _uploadImages(product.id);
        await product.reference.update(unsavedData);
      } else {
        DocumentReference ref = await FirebaseFirestore.instance
            .collection("products")
            .doc(categoryid)
            .collection("items")
            .add(Map.from(unsavedData)..remove("images"));
        await _uploadImages(ref.id);
        await ref.update(unsavedData);
        _loadController.add(false);
        _createdController.add(true);
        return true;
      }
    } catch (e) {
      print(e);
      _loadController.add(false);
      return false;
    }
    _loadController.add(false);
    return true;
  }

  Future _uploadImages(String id) async {
    for (int i = 0; i < unsavedData["images"].length; i++) {
      if (unsavedData["images"][i] is String) continue;

      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child(categoryid)
          .child(id)
          .child(DateTime.now().microsecondsSinceEpoch.toString())
          .putFile(unsavedData["images"][i]);

      TaskSnapshot s = await uploadTask.whenComplete(() => null);
      String downloadUrl = await s.ref.getDownloadURL();

      unsavedData["images"][i] = downloadUrl;
    }
  }
  void deleteProduct(){
    product.reference.delete();
  }

  @override
  void dispose() {
    _dataController.close();
    _loadController.close();
    _createdController.close();
  }
}

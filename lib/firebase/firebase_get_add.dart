import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseOptions {}

//pasar esto a un nuevo archivo independiente
CollectionReference db = FirebaseFirestore.instance.collection('products');

Future<List> getProducts() async {
  List products = [];
  QuerySnapshot queryProducts = await db.get();
  for (var doc in queryProducts.docs) {
    products.add(doc.data());
  }
  return products;
}

Future<void> addProduct(product) async {
  await db.add(product);
}

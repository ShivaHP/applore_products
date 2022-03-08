import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_notification/firebase_cart/blocs/createproduct_cubit/createproduct_cubit.dart';
import 'package:flutter_notification/firebase_cart/blocs/products_bloc/products_bloc.dart';
import 'package:flutter_notification/firebase_cart/config/collections.dart';
import 'package:flutter_notification/firebase_cart/models/product_model.dart';

class ProductsRepo {
  Future<void> createproduct(Map<String, String> data) async {
    try {
      await productscollection.add(data).catchError((err) {});
    } catch (e) {
      print(e);
      throw CreateProductException("Unable to create product");
    }
  }

  Future<Map> getproducts({DocumentSnapshot? lastdocument}) async {
    try {
      QuerySnapshot data;
      if (lastdocument == null) {
        data = await productscollection
            .orderBy("dt_created", descending: true)
            .limit(10)
            .get();
      } else {
        data = await productscollection
            .orderBy("dt_created", descending: true)
            .startAfterDocument(lastdocument)
            .limit(10)
            .get();
      }

      List<QueryDocumentSnapshot> docs = data.docs;
      QueryDocumentSnapshot? snapshot =
          docs.isNotEmpty ? docs[docs.length - 1] : null;
      return {
        "products":
            docs.map((e) => ProductModel.fromJson(e.data() as Map)).toList(),
        "snapshot": snapshot
      };
    } catch (e) {
      print("error:$e");
      throw FetchProductsException("Some error occured");
    }
  }
}

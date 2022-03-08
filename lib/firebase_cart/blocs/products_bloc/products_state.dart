import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_notification/firebase_cart/models/product_model.dart';

enum ProductsStatus { loading, success, failure }

class ProductsState {
  final List<ProductModel> products;
  final ProductsStatus status;
  final bool hasreachedmax;
  final DocumentSnapshot? lastsnapshot;
  ProductsState(
      {this.products = const [],
      this.status = ProductsStatus.success,
      this.hasreachedmax = false,this.lastsnapshot});


  ProductsState copyWith(
      {List<ProductModel>? products,
      ProductsStatus? status,
      bool? hasreachedmax,DocumentSnapshot? snapshot}) {
    return ProductsState(
        products: products ?? this.products,
        status: status ?? this.status,
        hasreachedmax: hasreachedmax ?? this.hasreachedmax,lastsnapshot: snapshot??this.lastsnapshot);
  }
}

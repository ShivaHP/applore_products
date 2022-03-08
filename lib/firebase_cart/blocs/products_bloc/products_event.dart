import 'package:flutter_notification/firebase_cart/models/product_model.dart';

abstract class ProductsEvent{

}

class FetchProducts implements ProductsEvent{
  
}

class AddNewProduct implements ProductsEvent{
  final ProductModel product;
  AddNewProduct(this.product);

}

class RefreshProductPage implements ProductsEvent{
  
}
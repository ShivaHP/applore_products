import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notification/firebase_cart/blocs/products_bloc/products_event.dart';
import 'package:flutter_notification/firebase_cart/blocs/products_bloc/products_state.dart';
import 'package:flutter_notification/firebase_cart/config/flutter_toast.dart';
import 'package:flutter_notification/firebase_cart/models/product_model.dart';
import 'package:flutter_notification/firebase_cart/repository/products_repo.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepo _repo;
  ProductsBloc(this._repo) : super(ProductsState()) {
    on<FetchProducts>(_fetchproducts);
    on<RefreshProductPage>(_getlatestproducts);
  }

  _fetchproducts(FetchProducts event, Emitter<ProductsState> emit) async {
    try {
      print("fetching product");
      if (state.hasreachedmax) {
        FlutterToast.showtoast("Maximum Products Reached");
        return;
      }
      emit(state.copyWith(status: ProductsStatus.loading));
      Map productdata =
          await _repo.getproducts(lastdocument: state.lastsnapshot);
          print(productdata);
      List<ProductModel> products = productdata["products"];
      List<ProductModel> listofproducts = [...state.products];
      
      listofproducts.addAll(products);
      emit(state.copyWith(
          products: listofproducts,
          status: ProductsStatus.success,
          snapshot: productdata["snapshot"],hasreachedmax: products.isEmpty?true:false));
    } on FetchProductsException catch (e) {
      emit(state.copyWith(status: ProductsStatus.failure));
      FlutterToast.showtoast(e.message);
    }
  }

  _getlatestproducts(
      RefreshProductPage event, Emitter<ProductsState> emit) async {
    emit(state.copyWith(status: ProductsStatus.loading));
    try {
      Map productdata = await _repo.getproducts();
      List<ProductModel> products = productdata["products"];
      state.copyWith(products: products);
      emit(state.copyWith(status: ProductsStatus.success,products: products,hasreachedmax: false,snapshot: productdata["snapshot"]));
    } on FetchProductsException catch (e) {
      emit(state.copyWith(status: ProductsStatus.failure));
      FlutterToast.showtoast(e.message);
    }
  }

  addnewproduct(AddNewProduct event, Emitter<ProductsState> emit) {
    List<ProductModel> listofproducts = [...state.products];
    listofproducts.insert(0, event.product);
    emit(state.copyWith(products: listofproducts));
  }
}

class FetchProductsException implements Exception {
  final String message;
  FetchProductsException(this.message);
}

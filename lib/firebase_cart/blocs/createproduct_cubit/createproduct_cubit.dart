import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_notification/firebase_cart/blocs/createproduct_cubit/createproduct_state.dart';
import 'package:flutter_notification/firebase_cart/config/flutter_toast.dart';
import 'package:flutter_notification/firebase_cart/repository/products_repo.dart';
import 'package:flutter_notification/firebase_cart/utils/services/uploadimage.dart';

import 'package:image_picker/image_picker.dart';

class CreateProductCubit extends Cubit<CreateProductState> {
  final ProductsRepo _productsRepo;
  CreateProductCubit(this._productsRepo) : super(CreateProductState());

  Future<void> createproduct() async {
  
    try {
      if (state.description.isEmpty ||
          state.imagefile == null ||
          state.name.isEmpty ||
          state.price.isEmpty) {
        FlutterToast.showtoast("Please fill all details");
        return;
      }
      emit(state.copyWith(status: CreateProductStatus.loading));

      Map<String, String> product = {
        "dt_created": DateTime.now().toString(),
        "name": state.name,
        "description": state.description,
        "imageurl": await getdownloadurl(state.compressedimage),
        "price": state.price,
      };
      await _productsRepo.createproduct(product);
      emit(state.copyWith(status: CreateProductStatus.success));
      FlutterToast.showtoast("Product Created Successfully");
    } on UploadFailed catch (e) {
      emit(state.copyWith(status: CreateProductStatus.failure));
      FlutterToast.showtoast(e.message);
    } on CreateProductException catch (e) {
      emit(state.copyWith(status: CreateProductStatus.failure));
      FlutterToast.showtoast(e.message);
    }
  }

  compressimage(XFile file) async {
    try {
      state.imagefile = File(file.path);
      FlutterToast.showtoast("Please wait compressing image");

      String targetpath = "";
      List<String> paths = file.path.split("/");
      for (int i = 1; i < paths.length; i++) {
        if (i > 5) {
          break;
        } else {
          targetpath += "/" + paths[i];
        }
      }
      targetpath = targetpath + "/${DateTime.now().millisecondsSinceEpoch}.jpg";
      File? compressedfile = await FlutterImageCompress.compressAndGetFile(
          file.path, targetpath,
          quality: 50);

      emit(state.copyWith(compresfile: compressedfile, file: state.imagefile));
    } on Exception catch (_) {
      FlutterToast.showtoast("Compression Failed");
    }
  }

  updateprodname(String name) {
    state.name = name;
  }

  updateproddesc(String description) {
    state.description = description;
  }

  updateprodprice(String price) {
    state.price = price;
  }
}

class CreateProductException implements Exception {
  final String message;
  CreateProductException(this.message);
}

class UploadFailed implements Exception {
  final String message;
  UploadFailed(this.message);
}

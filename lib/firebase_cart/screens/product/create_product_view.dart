import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notification/firebase_cart/blocs/createproduct_cubit/createproduct_cubit.dart';
import 'package:flutter_notification/firebase_cart/blocs/createproduct_cubit/createproduct_state.dart';
import 'package:flutter_notification/firebase_cart/config/palette.dart';
import 'package:flutter_notification/firebase_cart/repository/products_repo.dart';
import 'package:flutter_notification/firebase_cart/utils/extensions/spacing.dart';
import 'package:flutter_notification/firebase_cart/widgets/custom_textfield.dart';
import 'package:flutter_notification/firebase_cart/widgets/customappbar.dart';
import 'package:flutter_notification/firebase_cart/widgets/customelevatedbutton.dart';
import 'package:image_picker/image_picker.dart';

class CreateProduct extends StatelessWidget {
  static const String route = "/create_product";
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
 

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateProductCubit>(
      create: (context) => CreateProductCubit(context.read<ProductsRepo>()),
      child: Scaffold(
        appBar: CustomAppBar(
          title: "Create Product",
        ),
        body: Builder(builder: (context) {
          return SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Image.asset("assets/applore_create_product.png",height: 200,),
                  CustomField(
                    label: "Name",
                    hinttext: "Enter your product name",
                    onchanged: (text) {
                      context.read<CreateProductCubit>().updateprodname(text);
                    },
                  ).pad(top: 20, bottom: 20),
                  CustomField(
                    label: "Description",
                    hinttext: "Enter your product description",
                    onchanged: (text) {
                      context.read<CreateProductCubit>().updateproddesc(text);
                    },
                  ),
                  CustomField(
                    label: "Price",
                    hinttext: "Enter your product price",
                    isnumeric: true,
                    onchanged: (text) {
                      context.read<CreateProductCubit>().updateprodprice(text);
                    },
                  ).pad(
                    top: 20,
                    bottom: 20,
                  ),
                  ImagePickerCard(),
                  PhotoComparisonCard().pad(bottom: 20, top: 20),
                  BlocConsumer<CreateProductCubit, CreateProductState>(
                    listenWhen: ((previous, current) =>
                        previous.status != current.status),
                    listener: ((context, state) {
                      if (state.status == CreateProductStatus.success) {
                        Navigator.pop(context);
                      }
                    }),
                    buildWhen: (prevstate, nextstate) =>
                        prevstate.status != nextstate.status,
                    builder: (context, state) => CustomButton(
                      text: "Create Product",
                      callback:state.status==CreateProductStatus.loading?null: () {
                        if (formkey.currentState!.validate()) {
                          context.read<CreateProductCubit>().createproduct();
                        }
                      },
                    ),
                  )
                ],
              ),
            ).pad(left: 10, right: 10),
          );
        }),
      ),
    );
  }
}

class ImagePickerCard extends StatelessWidget {
  ImagePicker picker = ImagePicker();
  ImagePickerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductCubit, CreateProductState>(
        builder: (context, value) {
      return Container(
        decoration: BoxDecoration(
            color: purple, borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          onTap: () {
            pickimage(context);
          },
          trailing: Icon(
            Icons.chevron_right,
            color: Colors.black,
          ),
          leading: value.imagefile == null
              ? Image.asset(
                  "assets/applore_create_product.png",
                  width: 45,
                  height: 45,
                )
              : Image.file(
                  File(value.imagefile!.path),
                  width: 45,
                  height: 45,
                ),
          title: Text(
            "Add an image",
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            "PNG,JPG",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    });
  }

  pickimage(BuildContext context) {
    picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value == null) return;
      context.read<CreateProductCubit>().compressimage(value);
    });
  }
}

class PhotoComparisonCard extends StatelessWidget {
  const PhotoComparisonCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductCubit, CreateProductState>(
        builder: (context, state) {
      if (state.compressedimage == null || state.imagefile == null) {
        return Text("");
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            PhotoCard(
              file: state.imagefile!,
              imageinfo: "Original Image",
            ),
            PhotoCard(
              file: state.compressedimage!,
              imageinfo: "Compressed Image",
            )
          ],
        );
      }
    });
  }
}

class PhotoCard extends StatelessWidget {
  final File file;
  final String imageinfo;
  const PhotoCard({Key? key, required this.file, this.imageinfo = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text(
            imageinfo,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Image.file(
            file,
            width: size.width * .4,
            height: size.width * .4,
          ),
          Text((file.lengthSync() / 1000000).toStringAsFixed(2) + " MB")
        ],
      ),
    );
  }
}

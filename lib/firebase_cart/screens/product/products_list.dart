import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_notification/firebase_cart/blocs/authbloc/auth_bloc.dart';
import 'package:flutter_notification/firebase_cart/blocs/authbloc/auth_event.dart';
import 'package:flutter_notification/firebase_cart/blocs/products_bloc/products_bloc.dart';
import 'package:flutter_notification/firebase_cart/blocs/products_bloc/products_event.dart';
import 'package:flutter_notification/firebase_cart/blocs/products_bloc/products_state.dart';
import 'package:flutter_notification/firebase_cart/config/cache_image.dart';
import 'package:flutter_notification/firebase_cart/config/palette.dart';
import 'package:flutter_notification/firebase_cart/models/product_model.dart';
import 'package:flutter_notification/firebase_cart/screens/authentication/login.dart';
import 'package:flutter_notification/firebase_cart/screens/product/create_product_view.dart';
import 'package:flutter_notification/firebase_cart/utils/extensions/spacing.dart';
import 'package:flutter_notification/firebase_cart/utils/extensions/stringexten.dart';
import 'package:flutter_notification/firebase_cart/widgets/circular_progress.dart';

class ProductsList extends StatefulWidget {
  static const String route = "/product_list";
  const ProductsList({Key? key}) : super(key: key);

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  late ScrollController scrollController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController();
    context.read<ProductsBloc>().add(FetchProducts());
    scrollController.addListener(() {
      
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        context.read<ProductsBloc>().add(FetchProducts());
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ProductsBloc>().add(RefreshProductPage());
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: purple,
          onPressed: () {
            Navigator.pushNamed(context, CreateProduct.route);
          },
        ),
        appBar: AppBar(
          elevation: 1,
          leadingWidth: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Products List",
          ),
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 17),
          actions: [
            IconButton(
                onPressed: () {
                 
                  context.read<AuthBloc>().add(LogoutRequested());
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.black,
                ))
          ],
        ),
        body: BlocBuilder<ProductsBloc, ProductsState>(
            builder: ((context, state) {
          return Stack(
            children: [
             
              ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                controller: scrollController,
                itemBuilder: ((context, index) =>
                    ProductCard(product: state.products[index])),
                itemCount: state.products.length,
              ),
              Align(
                alignment: Alignment.center,
                child: BlocSelector<ProductsBloc, ProductsState, ProductsStatus>(
                    selector: (state) => state.status,
                    builder: (context, status) {
                      return Visibility(
                          visible: status == ProductsStatus.loading,
                          child: CustomCircularProgress());
                    }),
              )
            ],
          );
        })),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Container(color: Colors.grey.shade100,child: cacheimage(product.imageurl)),
            title: Text(product.productname),
            subtitle: Text(product.productdescription),
            trailing: Text("₹ " + product.price),
          ),
          
          Text("Created On: "+product.datecreated.todatewithmin(),style: TextStyle(fontSize: 12),).pad(left: 10,right: 10,bottom: 10)
        ],
      ),
    );
  }
}

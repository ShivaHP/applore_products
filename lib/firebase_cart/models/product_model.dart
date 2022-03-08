class ProductModel {
  final String productname;
  final String productdescription;
  final String imageurl;
  final String price;
  final String datecreated;
  final String userid;
  ProductModel(this.productname, this.productdescription, this.imageurl,
      this.price, this.datecreated,this.userid);

  factory ProductModel.fromJson(Map data) {
    return ProductModel(
        data["name"] ?? "",
        data["description"] ?? "",
        data["imageurl"] ?? "",
        data["price"] ?? "0",
        data["dt_created"] ?? "",
        data["uid"]??"");
  }


}

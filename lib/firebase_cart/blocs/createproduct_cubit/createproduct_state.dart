import 'dart:io';



enum CreateProductStatus{loading,failure,success}

class CreateProductState{
   String name;
   String description;
   String price;
   File? imagefile;
   CreateProductStatus status;
   File? compressedimage;
  CreateProductState({this.name="",this.description="",this.price="",this.imagefile,this.status=CreateProductStatus.success,this.compressedimage});

  CreateProductState copyWith({String? name,String? description,String? price,File? file,File? compresfile,CreateProductStatus? status}){
    return CreateProductState(
      name: name??this.name,
      description: description??this.description,
      price: price??this.price,
      imagefile: file??this.imagefile,
      compressedimage: compresfile??this.compressedimage,
      status: status??this.status
    );
  }
}
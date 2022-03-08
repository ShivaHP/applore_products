
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_notification/firebase_cart/blocs/createproduct_cubit/createproduct_cubit.dart';

Future<String> getdownloadurl(File? file)async{
  try {
    if(file==null)throw UploadFailed("Missing file");
  
    String task=await FirebaseStorage.instance.ref().child(file.path.split("/")[6]).putFile(file).then((val) =>val.ref.getDownloadURL());
    return task;
  
  }catch (_) {
  throw UploadFailed("Image upload failed");
  }

}


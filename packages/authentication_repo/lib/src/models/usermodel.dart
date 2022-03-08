import 'package:equatable/equatable.dart';

class UserModel implements Equatable{
  final String username;
  final String email;
  final String photo;
  final String uid;
 const UserModel({this.username="", this.email="", this.photo="",this.uid=""});

  static const empty=UserModel();

  bool get isempty=>this==UserModel.empty;

  bool get isNotEmpty=>this!=UserModel.empty;

  @override
  // TODO: implement props
  List<Object?> get props =>[username,email,photo,uid];

  @override
  // TODO: implement stringify
  bool? get stringify => true;

  Map toJson()=>{
    "username":username,
    "email":email,
    "photo":photo,
    "uid":uid
  };

}
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? name;
  String? email;
  String? role;
  Timestamp? createdAt;

  UserModel({this.name, this.email, this.role, this.createdAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    role = json['role'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['role'] = role;
    data['createdAt'] = createdAt;
    return data;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String? name;
  Timestamp? createdAt;
  String? description;

  CategoryModel({this.name, this.createdAt, this.description});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    createdAt = json['createdAt'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['createdAt'] = createdAt;
    data['description'] = description;
    return data;
  }
}

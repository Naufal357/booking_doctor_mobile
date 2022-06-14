import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorModel {
  String? name;
  DocumentReference? category;
  String? photoUrl;
  Timestamp? createdAt;

  DoctorModel({this.name, this.category, this.photoUrl, this.createdAt});

  DoctorModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    category = json['category'];
    photoUrl = json['photoUrl'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['category'] = category;
    data['photoUrl'] = photoUrl;
    data['createdAt'] = createdAt;
    return data;
  }
}

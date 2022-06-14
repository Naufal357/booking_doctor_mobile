import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  int? number;
  DocumentReference? userId;
  DocumentReference? doctorId;
  String? status;
  Timestamp? createdAt;
  Timestamp? updatedAt;

  OrderModel({this.number, this.userId, this.doctorId, this.status, this.createdAt, this.updatedAt});

  OrderModel.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    userId = json['userId'];
    doctorId = json['doctorId'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['userId'] = userId;
    data['doctorId'] = doctorId;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

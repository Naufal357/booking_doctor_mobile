import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/category_model.dart';
import '../../../data/models/doctor_model.dart';
import '../../../data/models/order_model.dart';
import '../../../data/models/user_model.dart';

class AdminQueueEditController extends GetxController {
  final String documentId = Get.arguments as String;

  final Rxn<OrderModel> order = Rxn<OrderModel>();
  final Rxn<UserModel> user = Rxn<UserModel>();
  final Rxn<DoctorModel> doctor = Rxn<DoctorModel>();
  final Rxn<CategoryModel> category = Rxn<CategoryModel>();

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    // fetch order data
    final snapshot = await FirebaseFirestore.instance.collection('orders').doc(documentId).get();
    final orderModel = OrderModel.fromJson(snapshot.data() as Map<String, dynamic>);

    // fetch user data
    final snapshotUser = await FirebaseFirestore.instance
        .collection('users')
        .doc(orderModel.userId!.path.replaceAll('users/', ''))
        .get();
    user.value = UserModel.fromJson(snapshotUser.data() as Map<String, dynamic>);

    // fetch doctor data
    final snapshotDoctor = await FirebaseFirestore.instance
        .collection('doctors')
        .doc(orderModel.doctorId!.path.replaceAll('doctors/', ''))
        .get();

    if (snapshotDoctor.data() != null) {
      doctor.value = DoctorModel.fromJson(snapshotDoctor.data() as Map<String, dynamic>);

      // fetch category data
      final snapshotCategory = await FirebaseFirestore.instance
          .collection('categories')
          .doc(doctor.value!.category!.path.replaceAll('categories/', ''))
          .get();
      category.value = CategoryModel.fromJson(snapshotCategory.data() as Map<String, dynamic>);
    }

    order.value = orderModel;
  }

  void cancelOrder() async {
    Get.defaultDialog(
      title: 'Konfirmasi',
      content: Text('Apakah anda yakin ingin membatalkan pesanan ini?'),
      textConfirm: 'Ya',
      onConfirm: () async {
        await FirebaseFirestore.instance.collection('orders').doc(documentId).update({'status': 'batal'});
        Get.back();
        Get.back();
      },
      textCancel: 'Tidak',
      buttonColor: Colors.red,
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.black,
    );
  }

  void completeOrder() async {
    Get.defaultDialog(
      title: 'Konfirmasi',
      content: Text('Apakah anda yakin ingin menyelesaikan pesanan ini?'),
      textConfirm: 'Ya',
      onConfirm: () async {
        await FirebaseFirestore.instance.collection('orders').doc(documentId).update({'status': 'selesai'});
        Get.back();
        Get.back();
      },
      textCancel: 'Tidak',
      buttonColor: Colors.green,
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.black,
    );
  }
}

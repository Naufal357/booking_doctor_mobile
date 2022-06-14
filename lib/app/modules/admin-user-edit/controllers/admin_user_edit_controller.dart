import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_doctor_mobile/app/data/models/user_model.dart';

class AdminUserEditController extends GetxController {
  final String documentId = Get.arguments as String;
  final formKey = GlobalKey<FormState>();
  final Rx<UserModel> data = UserModel().obs;
  final RxBool loading = true.obs;
  final RxBool submitted = false.obs;

  final RxString name = ''.obs;
  final RxString email = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    final snapshot = await FirebaseFirestore.instance.collection('users').doc(documentId).get();
    data.value = UserModel.fromJson(snapshot.data() as Map<String, dynamic>);

    name.value = data.value.name!;
    email.value = data.value.email!;

    loading.toggle();
  }

  void delete() async {
    Get.defaultDialog(
      title: 'Hapus User',
      middleText: 'Apakah anda yakin ingin menghapus user ini?',
      textConfirm: 'Ya',
      onConfirm: () async {
        final userRef = FirebaseFirestore.instance.collection('users').doc(documentId);

        // delete all orders from this user
        final docRefs = FirebaseFirestore.instance.collection('orders').where('userId', isEqualTo: userRef);
        final snapshot = await docRefs.get();

        final docs = snapshot.docs;

        await Future.wait([
          for (final doc in docs) FirebaseFirestore.instance.collection('orders').doc(doc.id).delete(),
        ]);

        await FirebaseFirestore.instance.collection('users').doc(documentId).delete();

        Get.back();
        Get.back();
      },
      buttonColor: Colors.red,
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.black,
      textCancel: 'Tidak',
    );
  }
}

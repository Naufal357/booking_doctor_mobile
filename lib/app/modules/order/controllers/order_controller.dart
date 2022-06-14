import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_doctor_mobile/app/data/models/category_model.dart';
import 'package:booking_doctor_mobile/app/data/models/order_model.dart';

import '../../../data/models/doctor_model.dart';
import '../../../data/models/user_model.dart';
import '../../../routes/app_pages.dart';

class OrderController extends GetxController {
  final DocumentReference docRef = Get.arguments as DocumentReference;
  final Rxn<DoctorModel> doctor = Rxn<DoctorModel>();
  final Rxn<CategoryModel> category = Rxn<CategoryModel>();

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    // fetch doctor data
    final dataDoctor = await docRef.get();
    final doctorModel = DoctorModel.fromJson(dataDoctor.data() as Map<String, dynamic>);

    // fetch category
    final dataCategory = await doctorModel.category!.get();
    category.value = CategoryModel.fromJson(dataCategory.data() as Map<String, dynamic>);

    doctor.value = doctorModel;
  }

  void order() async {
    Get.defaultDialog(
      title: 'Konfirmasi',
      content: Text('Apakah anda yakin ingin memesan dokter ini?'),
      textConfirm: 'Ya',
      onConfirm: () async {
        // get counter from firestore options collection doc 1
        final snapshot = await FirebaseFirestore.instance.collection('options').doc('1').get();
        final counter = snapshot.data()!['counter'] as int;

        // increment counter
        await FirebaseFirestore.instance.collection('options').doc('1').update({'counter': counter + 1});

        // get user where email
        final snapshotUser = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
            .get();

        // create order data
        final orderData = OrderModel(
          createdAt: Timestamp.now(),
          updatedAt: Timestamp.now(),
          doctorId: docRef,
          number: counter,
          status: 'pending',
          userId: FirebaseFirestore.instance.collection('users').doc(snapshotUser.docs[0].id),
        );

        // create order
        await FirebaseFirestore.instance.collection('orders').add(orderData.toJson());

        // back to home
        Get.offNamedUntil('/home', (route) => false);
      },
      textCancel: 'Tidak',
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_doctor_mobile/app/data/models/category_model.dart';

class AdminCategoryAddController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final RxBool submitted = false.obs;

  final RxString name = ''.obs;
  final RxString description = ''.obs;

  void submit() async {
    if (formKey.currentState!.validate()) {
      submitted.toggle();
      formKey.currentState!.save();

      final data = CategoryModel(
        name: name.value,
        description: description.value,
        createdAt: Timestamp.now(),
      );

      createCategory(data);

      Get.back();
    }
  }

  void createCategory(CategoryModel data) async {
    try {
      await FirebaseFirestore.instance.collection('categories').add(data.toJson());
    } catch (_) {}
  }
}

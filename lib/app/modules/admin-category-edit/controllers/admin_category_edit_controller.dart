import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_doctor_mobile/app/data/models/category_model.dart';

class AdminCategoryEditController extends GetxController {
  final String documentId = Get.arguments as String;
  final formKey = GlobalKey<FormState>();
  final Rx<CategoryModel> data = CategoryModel().obs;
  final RxBool loading = true.obs;
  final RxBool submitted = false.obs;

  final RxString name = ''.obs;
  final RxString description = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    final snapshot = await FirebaseFirestore.instance.collection('categories').doc(documentId).get();
    data.value = CategoryModel.fromJson(snapshot.data() as Map<String, dynamic>);

    name.value = data.value.name!;
    description.value = data.value.description!;

    loading.toggle();
  }

  void edit() async {
    if (formKey.currentState!.validate()) {
      submitted.toggle();

      // do login with firebase auth
      try {
        await FirebaseFirestore.instance.collection('categories').doc(documentId).update({
          'name': name.value,
          'description': description.value,
        });

        Get.back();
      } catch (_) {}
    }
  }

  void delete() async {
    Get.defaultDialog(
      title: 'Hapus Kategori',
      middleText: 'Apakah anda yakin ingin menghapus kategori ini?',
      textConfirm: 'Ya',
      onConfirm: () async {
        // get all doctors where category is this category
        final snapshot = await FirebaseFirestore.instance
            .collection('doctors')
            .where('category', isEqualTo: FirebaseFirestore.instance.collection('categories').doc(documentId))
            .get();

        // delete all doctors where category is this category
        for (final doc in snapshot.docs) {
          // delete all orders where doctorId is this doctor
          await FirebaseFirestore.instance
              .collection('orders')
              .where('doctorId', isEqualTo: FirebaseFirestore.instance.collection('doctors').doc(doc.id))
              .get()
              .then((snapshot) {
            for (var doc in snapshot.docs) {
              FirebaseFirestore.instance.collection('orders').doc(doc.id).delete();
            }
          });

          FirebaseFirestore.instance.collection('doctors').doc(doc.id).delete();
        }

        await FirebaseFirestore.instance.collection('categories').doc(documentId).delete();

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

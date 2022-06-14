import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DoctorController extends GetxController {
  final docRef = Get.arguments as DocumentReference;

  Query<Map<String, dynamic>> get getQuery => FirebaseFirestore.instance
      .collection('doctors')
      .where('category', isEqualTo: docRef)
      .orderBy('createdAt');
}

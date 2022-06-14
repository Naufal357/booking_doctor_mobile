import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminDoctorController extends GetxController {
  final query = FirebaseFirestore.instance.collection('doctors').orderBy('createdAt', descending: true);
}

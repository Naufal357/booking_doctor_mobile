import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AdminUserController extends GetxController {
  final query = FirebaseFirestore.instance
      .collection('users')
      .where('role', isEqualTo: 'user')
      .orderBy('createdAt', descending: true);
}

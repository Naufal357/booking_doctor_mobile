import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class OrderHistoryController extends GetxController {
  final Rxn<DocumentReference> userRef = Rxn<DocumentReference>();
  final Rxn<Query<Map<String, dynamic>>> query = Rxn<Query<Map<String, dynamic>>>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRef();
  }

  void fetchUserRef() async {
    final user = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();

    query.value = FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: user.docs[0].reference)
        .where('status', isNotEqualTo: 'pending')
        .orderBy('status')
        .orderBy('createdAt', descending: true);

    userRef.value = user.docs[0].reference;
  }
}

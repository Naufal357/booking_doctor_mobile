import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminOrderController extends GetxController {
  final query = FirebaseFirestore.instance
      .collection('orders')
      .where('status', isNotEqualTo: 'pending')
      .orderBy('status')
      .orderBy('createdAt', descending: true);

  
}
